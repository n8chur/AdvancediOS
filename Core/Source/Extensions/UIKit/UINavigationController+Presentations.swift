import UIKit
import ReactiveSwift
import Result

public extension UINavigationController {

    public func makePushPresentation<ViewController: UIViewController>(of viewController: ViewController) -> DismissablePresentation<ViewController> {
        let present: DismissablePresentation<ViewController>.MakePresent = { [weak self] (viewController, animated) in
            guard let self = self else { fatalError() }

            return self.reactive.pushViewController.apply((viewController, animated))
                .flatMapError { _ in return SignalProducer<Never, NoError>.empty }
        }

        let dismiss: DismissablePresentation<ViewController>.MakeDismiss = { [weak self] (viewController, animated) in
            guard let self = self else { fatalError() }

            return self.reactive.popViewController.apply((viewController, animated))
                .flatMapError { _ in return SignalProducer<Never, NoError>.empty }
        }

        let didDismiss = viewController.reactive.didMoveToNilParent.map { _ in return () }

        let presentation = DismissablePresentation(
            presentedViewController: viewController,
            present: present,
            dismiss: dismiss,
            didDismiss: didDismiss)

        // Retain the presentation for its lifecycle.
        presentation.didDismiss.producer
            .untilDisposal(retain: presentation)
            .take(duringLifetimeOf: viewController)
            .take(duringLifetimeOf: self)
            .start()

        return presentation
    }

}
