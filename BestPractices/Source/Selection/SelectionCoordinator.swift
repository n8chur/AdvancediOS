import UIKit
import Core
import ReactiveSwift
import Result

class SelectionCoordinator: Coordinator {

    typealias ViewModel = SelectionViewModel
    typealias StartError = SelectionPresentError

    private weak var presentingViewController: UIViewController?

    private(set) lazy var start = Action<ViewModel, (), StartError> { [weak self] viewModel in
        return SignalProducer<SelectionViewController, NoError> { SelectionViewController(viewModel: viewModel) }
            .map(UINavigationController.init)
            .flatMap(.merge) { navigationController -> SignalProducer<(), ActionError<NoError>> in
                guard
                    let strongSelf = self,
                    let presentingViewController = strongSelf.presentingViewController else {
                        fatalError()
                }

                // Ensure that the navigation controller is dismissed when the view model's submit action sends a value
                // since this indicates that selection is complete.
                let dismissOnSubmission = viewModel.submit.values
                    .take(first: 1)
                    .producer
                    .then(navigationController.reactive.dismiss.apply(true))
                    .then(SignalProducer(value: navigationController))

                // Make the signal last until the navigation controller is dismissed.
                //
                // This ensures that the coordinator will be alive while the view controller is in the navigation stack
                // since it is retained for the duration of the start command (see detailViewPresentation(in:of:)).
                //
                // This also ensures that the start action will be disabled while this view controller is already in the
                // navigation stack since the Action will still be executing.
                let didDismiss = navigationController.reactive
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

                return presentingViewController.reactive.present.apply((navigationController, true))
                    .then(dismissal)
            }
            .mapError { _ in return .unknown }
    }

    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }

}

extension SelectionCoordinator {

    static func selectionPresentation(over viewController: UIViewController, for viewModel: SelectionViewModel) -> SignalProducer<(), SelectionPresentationError> {
        return SignalProducer<SelectionCoordinator, NoError> { SelectionCoordinator(presentingViewController: viewController) }
            .flatMap(.merge) { coordinator in
                return coordinator.start.apply(viewModel)
                    // This keeps the coordinator alive while the presentation is still active to ensure it can handle
                    // any presentation callbacks.
                    .untilDisposal(retain: coordinator)
            }
            .ignoreValues()
            .mapError { _ in return .unknown }
    }

}
