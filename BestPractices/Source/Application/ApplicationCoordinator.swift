import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift
import Result

/// The flow coordinator for the application.
///
/// This class is responsible for:
/// - Setting up the window with the appropriate views and handle all view routing
/// - Handling presentation of views controllers
/// - Forwarding view model creation to the view model factory it was initialized with
class ApplicationCoordinator {

    let viewModelFactory: ApplicationViewModelFactory
    let window: UIWindow
    let navigationController = UINavigationController(nibName: nil, bundle: nil)

    init(viewModelFactory: ApplicationViewModelFactory, window: UIWindow) {
        self.viewModelFactory = viewModelFactory
        self.window = window
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let viewModel = RootViewModel()

        viewModel.detailPresenter = self

        let rootViewController = makeRootViewController(viewModel: viewModel)

        navigationController.viewControllers = [ rootViewController ]
    }

    private func makeRootViewController(viewModel: RootViewModel) -> RootViewController {
        return RootViewController(viewModel: viewModel)
    }

    private func makeDetailViewController(viewModel: DetailViewModel) -> DetailViewController {
        return DetailViewController(viewModel: viewModel)
    }

    private func makeSelectionViewController(viewModel: SelectionViewModel) -> SelectionViewController {
        return SelectionViewController(viewModel: viewModel)
    }

}

extension ApplicationCoordinator: DetailPresenter {

    func makeDetailViewModel() -> DetailViewModel {
        return viewModelFactory.makeDetailViewModel()
    }

    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<Never, NoError> {
        let viewController = SignalProducer<DetailViewController, NoError> { [weak self] () -> DetailViewController in
            guard let self = self else { fatalError() }

            viewModel.selectionPresenter = self

            return self.makeDetailViewController(viewModel: viewModel)
        }

        return viewController.flatMap(.merge) { [weak self] viewController -> SignalProducer<Never, NoError> in
            guard let self = self else { fatalError() }

            let presentation = self.navigationController.makePushPresentation(of: viewController)

            return presentation.present.apply(true)
                .flatMapError { _ in return SignalProducer<Never, NoError>.empty }
        }
    }

}

extension ApplicationCoordinator: SelectionPresenter {

    func makeSelectionViewModel() -> SelectionViewModel {
        return viewModelFactory.makeSelectionViewModel()
    }

    func selectionPresentation(of viewModel: SelectionViewModel) -> SignalProducer<Never, NoError> {
        let viewController = SignalProducer<SelectionViewController, NoError> { [weak self] () -> SelectionViewController in
            guard let self = self else { fatalError() }

            return self.makeSelectionViewController(viewModel: viewModel)
        }

        return viewController.flatMap(.merge) { [weak self] viewController -> SignalProducer<Never, NoError> in
            guard let self = self else { fatalError() }

            let selectionNavigationController = UINavigationController(rootViewController: viewController)

            let presentation = self.navigationController.makeModalPresentation(of: selectionNavigationController)
            presentation.addCancelBarButtonItem(to: viewController, animated: true)

            let dismiss = presentation.dismiss.apply(true)
                .flatMapError { _ in return SignalProducer<Never, NoError>.empty }

            // Ensure that the navigation controller is dismissed when the view model's submit action sends a value
            // since this indicates that selection is complete.
            viewModel.submit.values
                .producer
                .take(first: 1)
                .then(dismiss)
                .start()

            return presentation.present.apply(true)
                .flatMapError { _ in return SignalProducer<Never, NoError>.empty }
        }
    }

}
