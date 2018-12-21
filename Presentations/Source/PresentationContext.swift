import UIKit
import ReactiveSwift
import Result
import RxExtensions

public protocol PresentationContext: class {
    associatedtype ViewModelType: ViewModel
    associatedtype PresentationType: Presentation
    var presentation: PresentationType { get }
    var viewModel: ViewModelType { get }
    var presentAnimated: Bool { get }
}

/// A context for a presentation.
///
/// Contains additional information about a presentation in a specific presentation, like whether or not the presentation
/// and dismissal should be animated.
public class DismissablePresentationContext<PresentedViewModel: ViewModel>: PresentationContext {

    public typealias PresentationType = DismissablePresentation
    public typealias ViewModelType = PresentedViewModel

    public let presentation: DismissablePresentation
    public let viewModel: PresentedViewModel
    public let presentAnimated: Bool
    public let dismissAnimated: Bool

    public init(presentation: DismissablePresentation, viewModel: PresentedViewModel, presentAnimated: Bool = true, dismissAnimated: Bool = true) {
        self.presentation = presentation
        self.viewModel = viewModel
        self.presentAnimated = presentAnimated
        self.dismissAnimated = dismissAnimated
    }

}

/// A dismissible presentation that dismisses when the provided result view model's result signal sends a value.
public class ResultPresentationContext<PresentedViewModel: ResultViewModel>: DismissablePresentationContext<PresentedViewModel> {

    override public init(presentation: DismissablePresentation, viewModel: PresentedViewModel, presentAnimated: Bool = true, dismissAnimated: Bool = true) {
        super.init(presentation: presentation, viewModel: viewModel, presentAnimated: presentAnimated, dismissAnimated: dismissAnimated)

        let dismiss = presentation.dismiss.apply(dismissAnimated)
            .flatMapError { _ in return SignalProducer<Never, NoError>.empty }

        // Wait until the dismiss action is enabled before dismissing.
        let dismissWhenEnabled = presentation.dismiss.isEnabled.producer
            // Observe on the main queue scheduler to avoid a deadlock if this all happens synchronously.
            .observe(on: QueueScheduler.main)
            .filter { $0 }
            .take(first: 1)
            .whenTrue(subscribeTo: dismiss)
            .take(until: presentation.didDismiss)

        // When a result is received begin waiting for the dismiss action to be enabled and then dismiss.
        viewModel.result.producer
            .take(first: 1)
            .then(dismissWhenEnabled)
            .take(until: presentation.didDismiss)
            .start()
    }

}
