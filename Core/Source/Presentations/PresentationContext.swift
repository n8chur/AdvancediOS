import UIKit
import ReactiveSwift
import Result

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
