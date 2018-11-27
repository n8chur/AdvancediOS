import UIKit
import ReactiveSwift
import Result

/// A dismissable presentation (e.g. navigation push, modal presentation, etc.).
///
/// Presentation are single use. After the present command has been executed, a new presentation will need to be created
/// to start a another presentation.
public class DismissablePresentation {

    public typealias MakePresent = (_ presentedViewController: UIViewController, _ animated: Bool) -> SignalProducer<Never, NoError>
    public typealias MakeDismiss = (_ presentedViewController: UIViewController, _ animated: Bool) -> SignalProducer<Never, NoError>

    public let viewController: UIViewController

    /// The action that begins executing the producer returned from the present producer (provided by the MakePresent
    /// closure at intialization time). The action's execution signal completes when the signal producer's signal
    /// completes.
    ///
    /// This action is only enabled when the view controller has not yet been presented.
    public let present: Action<Bool, Never, NoError>

    /// The action that begins executing the producer returned from the dismiss producer (provided by the MakeDismiss
    /// closure at intialization time). The action's execution signal completes when the signal producer's signal
    /// completes.
    ///
    /// This action is only enabled after presentation completes.
    public let dismiss: Action<Bool, Never, NoError>

    /// Sends () and then completes when the view controller dismisses (either through the the dismiss action or a value
    /// is sent along the didDismiss signal provided at intialization).
    ///
    /// This action will be disabled while the
    public let didDismiss: Signal<(), NoError>

    /// - Parameter viewController: The view controller being presented.
    /// - Parameter present: A closure that returns a signal producer that will be created and started when the present
    ///             action is executed. This signal producer should present the associated view controller.
    /// - Parameter dismiss: A closure that returns a signal producer that will be created and started when the dismiss
    ///             action is executed. This signal producer should dismiss the associated view controller.
    /// - Parameter didDismiss: Should send a value and then complete when the view controller did dismiss. In the case
    ///             of a view controller being presented in a navigation controller, this may be a signal that sends ()
    ///             when the view controller's parent becomes nil.
    public init(presentedViewController viewController: UIViewController, present: @escaping MakePresent, dismiss: @escaping MakeDismiss, didDismiss: Signal<(), NoError>) {
        self.viewController = viewController

        let canPresent = MutableProperty<Bool>(true)
        let canDismiss = MutableProperty<Bool>(false)

        self.present = Action<Bool, Never, NoError>(enabledIf: canPresent, execute: { animated -> SignalProducer<Never, NoError> in
            return present(viewController, animated)
        })

        self.dismiss = Action<Bool, Never, NoError>(enabledIf: canDismiss, execute: { animated -> SignalProducer<Never, NoError> in
            return dismiss(viewController, animated)
        })

        self.didDismiss = Signal
            .merge([
                self.dismiss.completed,
                didDismiss,
            ])
            .take(first: 1)

        let falseDuringPresentation = self.present.isExecuting.signal
            .filter { $0 }
            .map { _ in return false }

        canPresent <~ falseDuringPresentation

        let falseDuringDismissActionExecution = self.dismiss.isExecuting.signal
            .filter { $0 }
            .map { _ in return false }

        let trueAfterFirstPresentation = self.present.completed
            .map { true }
            .take(first: 1)

        canDismiss <~ Signal
            .merge([
                trueAfterFirstPresentation,
                falseDuringDismissActionExecution,
                self.didDismiss.map { false },
            ])
            .skipRepeats()
    }

}

/// A context for a presentation.
///
/// Contains additional information about a presentation in a specific presentation, like whether or not the presenation
/// and dismissal should be animated.
public class DismissablePresentationContext {

    public let presentation: DismissablePresentation
    public let presentAnimated: Bool
    public let dismissAnimated: Bool

    public init(presentation: DismissablePresentation, presentAnimated: Bool = true, dismissAnimated: Bool = true) {
        self.presentation = presentation
        self.presentAnimated = presentAnimated
        self.dismissAnimated = dismissAnimated
    }

}

/// A dismissable presentation that dismisses when the provided result view model's result signal sends a value.
public class ResultPresentationContext<ViewModel: ResultViewModel>: DismissablePresentationContext {

    public let viewModel: ViewModel

    public init(presentation: DismissablePresentation, viewModel: ViewModel, presentAnimated: Bool = true, dismissAnimated: Bool = true) {
        self.viewModel = viewModel

        super.init(presentation: presentation, presentAnimated: presentAnimated, dismissAnimated: dismissAnimated)

        let dismiss = presentation.dismiss.apply(dismissAnimated)
            .flatMapError { _ in return SignalProducer<Never, NoError>.empty }

        // Begin capturing a result value immediately.
        let capturedResult = viewModel.result.producer
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

}
