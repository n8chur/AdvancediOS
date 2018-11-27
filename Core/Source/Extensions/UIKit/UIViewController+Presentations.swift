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
    /// If a result view model is provided the view controller will be dismissed when its result signal sends a value.
    /// Result values begin being capturtued immediately but will not cause a dismissal until the present action has
    /// completed.
    public func makeCancellablePresentationContext<ViewModel: ResultViewModel>(of viewController: UIViewController, viewModel: ViewModel, presentAnimated: Bool = true, dismissAnimated: Bool = true) -> DismissablePresentationContext {
        let navigationController = UINavigationController(rootViewController: viewController)
        let presentation = makeModalPresentation(of: navigationController)
        let context = ResultPresentationContext(presentation: presentation, viewModel: viewModel, presentAnimated: presentAnimated, dismissAnimated: dismissAnimated)
        context.addCancelBarButtonItem(to: viewController)
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
