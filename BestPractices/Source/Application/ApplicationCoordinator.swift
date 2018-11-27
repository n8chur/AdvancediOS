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
/// - Forwarding view controller creation to the view controller factory it was initialized with
class ApplicationCoordinator {

    let viewModelFactory: ApplicationViewModelFactory
    let viewControllerFactory: ApplicationViewControllerFactory
    let window: UIWindow
    let navigationController = UINavigationController(nibName: nil, bundle: nil)

    init(viewModelFactory: ApplicationViewModelFactory, viewControllerFactory: ApplicationViewControllerFactory, window: UIWindow) {
        self.viewModelFactory = viewModelFactory
        self.viewControllerFactory = viewControllerFactory
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

}

extension ApplicationCoordinator: DetailPresenter {

    func makeDetailViewModel() -> DetailViewModel {
        return viewModelFactory.makeDetailViewModel()
    }

    func detailPresentationContext(of viewModel: DetailViewModel) -> DismissablePresentationContext {
        let viewController = viewControllerFactory.makeDetailViewController(viewModel: viewModel)
        let presentation = navigationController.makePushPresentation(of: viewController)
        return DismissablePresentationContext(presentation: presentation)
    }

}

extension ApplicationCoordinator: SelectionPresenter {

    func makeSelectionViewModel() -> SelectionViewModel {
        return viewModelFactory.makeSelectionViewModel()
    }

    func selectionPresentationContext(of viewModel: SelectionViewModel) -> DismissablePresentationContext {
        let viewController = viewControllerFactory.makeSelectionViewController(viewModel: viewModel)

        let result = viewModel.submit.values.map { _ in return () }
        return self.navigationController.makeCancellablePresentationContext(of: viewController, result: result)
    }

}
