import UIKit
import Core
import ReactiveSwift
import Result

class SelectionCoordinator: Coordinator {

    typealias ViewModel = SelectionViewModel
    typealias StartError = SelectionPresentError

    let presentingViewController: UIViewController

    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }

    private(set) lazy var start = Action<ViewModel, (), StartError> { viewModel in
        return SignalProducer<SelectionViewController, NoError> { SelectionViewController(viewModel: viewModel) }
            .map(UINavigationController.init)
            .flatMap(.merge) { [weak self] navigationController -> SignalProducer<(), ActionError<NoError>> in
                guard let strongSelf = self else {
                    fatalError()
                }

                let dismissOnSubmission = viewModel.submit.values.take(first: 1)
                    .producer
                    .then(navigationController.reactive.dismiss.apply(true))

                let didDismiss = navigationController.reactive
                    .didDismiss
                    .take(first: 1)
                    .ignoreValues()
                    .producer

                let dismissal = SignalProducer.merge([
                    didDismiss.promoteError(ActionError<NoError>.self),
                    dismissOnSubmission,
                ])

                return strongSelf.presentingViewController.reactive.present.apply((navigationController, true))
                    .then(dismissal)
            }
            .mapError { _ in return .unknown }
    }
}
