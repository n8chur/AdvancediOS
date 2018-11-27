import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

public extension UIViewController {

    public func makeModalPresentation(of viewController: UIViewController) -> DismissablePresentation {
        let present: DismissablePresentation.MakePresent = { [weak self] (viewController, animated) in
            guard let self = self else { fatalError() }

            return self.reactive.present.apply((viewController, animated))
                .flatMapError { _ in return SignalProducer<Never, NoError>.empty }
        }

        let dismiss: DismissablePresentation.MakeDismiss = { (viewController, animated) in
            return viewController.reactive.dismiss.apply(animated)
                .flatMapError { _ in return SignalProducer<Never, NoError>.empty }
        }

        let didDismiss = viewController.reactive.didDismiss.map { _ in return () }

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

    /// Wraps the provided view controller in a navigation controller, adds a cancel button to the navigation item's
    /// left bar button item that calls the presentation's dismiss command.
    ///
    /// If a value is sent along the result signal the preesnted navigation controller will be dismissed. Result values
    /// begin being capturtued immediately but will not cause a dismissal until the present action has completed.
    public func makeCancellablePresentationContext(of viewController: UIViewController, presentAnimated: Bool = true, dismissAnimated: Bool = true, result: Signal<(), NoError>? = nil) -> DismissablePresentationContext {
        let navigationController = UINavigationController(rootViewController: viewController)
        let presentation = makeModalPresentation(of: navigationController)
        let context = DismissablePresentationContext(presentation: presentation, presentAnimated: presentAnimated, dismissAnimated: dismissAnimated)
        context.addCancelBarButtonItem(to: viewController)

        if let result = result {
            let dismiss = presentation.dismiss.apply(context.dismissAnimated)
                .flatMapError { _ in return SignalProducer<Never, NoError>.empty }

            // Begin capturing a result value immediately.
            let capturedResult = result.producer
                .take(duringLifetimeOf: presentation)
                .take(first: 1)
                .replayLazily(upTo: 1)
            capturedResult.start()

            let dismissOnResult = capturedResult.producer
                .then(dismiss)

            // Wait until the dismiss action is enabled before dismissing from a result.
            presentation.dismiss.isEnabled.signal.producer
                .whenTrue(subscribeTo: dismissOnResult)
                .take(until: presentation.didDismiss)
                .start()
        }

        return context
    }

}

public extension DismissablePresentationContext {

    /// Sets the left navigation item to be a cancel button that executes the dimiss action.
    ///
    /// - Parameter viewController: The view controller to add the navigation item to.
    public func addCancelBarButtonItem(to viewController: UIViewController) {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        cancelButton.reactive.pressed = CocoaAction(presentation.dismiss, input: dismissAnimated)
        viewController.navigationItem.leftBarButtonItem = cancelButton
    }

}
