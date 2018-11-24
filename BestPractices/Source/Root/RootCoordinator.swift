import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift
import Result

class RootCoordinator {

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

        let rootViewController = RootViewController(viewModel: viewModel)

        navigationController.viewControllers = [ rootViewController ]
    }

}

extension RootCoordinator: DetailPresenter {

    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<(), DetailPresentationError> {
        return SignalProducer<DetailViewController, NoError> { DetailViewController(viewModel: viewModel) }
            .flatMap(.merge) { [weak self] viewController -> SignalProducer<DetailViewController, ActionError<NoError>> in
                guard let self = self else {
                    fatalError()
                }

                viewModel.selectionPresenter = self

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

extension RootCoordinator: SelectionPresenter {

    func selectionPresentation(of viewModel: SelectionViewModel) -> SignalProducer<(), SelectionPresentationError> {
        return SignalProducer<SelectionViewController, NoError> { SelectionViewController(viewModel: viewModel) }
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

                // Make the signal last until the navigation controller is dismissed.
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
