import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift
import Result

class ApplicationCoordinator {

    let window: UIWindow
    let navigationController = UINavigationController(nibName: nil, bundle: nil)

    init(window: UIWindow) {
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

    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<(), DetailPresentationError> {
        let viewController = SignalProducer<DetailViewController, NoError> { [weak self] () -> DetailViewController in
            guard let self = self else { fatalError() }

            viewModel.selectionPresenter = self

            let viewController = self.makeDetailViewController(viewModel: viewModel)

            return viewController
        }

        return viewController
            .flatMap(.merge) { [weak self] viewController -> SignalProducer<DetailViewController, ActionError<NoError>> in
                guard let self = self else { fatalError() }

                // Make the signal last until the view controller is removed from the navigation stack.
                let didMoveToNilParent = viewController.reactive.didMoveToNilParent
                    .producer
                    .take(first: 1)

                return self.navigationController.reactive.pushViewController.apply((viewController, true))
                    .then(didMoveToNilParent.promoteError(ActionError<NoError>.self))
            }
            .ignoreValues()
            .mapError { _ in return .unknown }
    }

}

extension ApplicationCoordinator: SelectionPresenter {

    func selectionPresentation(of viewModel: SelectionViewModel) -> SignalProducer<(), SelectionPresentationError> {
        let viewController = SignalProducer<SelectionViewController, NoError> { [weak self] () -> SelectionViewController in
            guard let self = self else { fatalError() }

            return self.makeSelectionViewController(viewModel: viewModel)
        }

        return viewController
            .map(UINavigationController.init)
            .flatMap(.merge) { [weak self] selectionNavigationController -> SignalProducer<(), ActionError<NoError>> in
                guard let self = self else {
                    fatalError()
                }

                // Ensure that the navigation controller is dismissed when the view model's submit action sends a value
                // since this indicates that selection is complete.
                let dismissOnSubmission = viewModel.submit.values
                    .take(first: 1)
                    .producer
                    .then(selectionNavigationController.reactive.dismiss.apply(true))
                    .then(SignalProducer(value: selectionNavigationController))

                // Make the returned signal producer's signal lifecycle last until the navigation controller is
                // dismissed.
                let didDismiss = selectionNavigationController.reactive
                    .didDismiss
                    .take(first: 1)
                    .producer

                let dismissal = SignalProducer
                    .merge([
                        didDismiss.promoteError(ActionError<NoError>.self),
                        dismissOnSubmission,
                    ])
                    .take(first: 1)
                    .ignoreValues()

                return self.navigationController.reactive.present.apply((selectionNavigationController, true))
                    .then(dismissal)
            }
            .mapError { _ in return .unknown }
    }

}
