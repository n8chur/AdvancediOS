import UIKit
import RxSwift
import RxExtensions

public protocol PresentationContext: AnyObject {
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
///
/// This context retains itself until the presentation's didDismiss observable sends a value.
public class ResultPresentationContext<PresentedViewModel: ResultViewModel>: DismissablePresentationContext<PresentedViewModel> {

    override public init(presentation: DismissablePresentation, viewModel: PresentedViewModel, presentAnimated: Bool = true, dismissAnimated: Bool = true) {
        super.init(presentation: presentation, viewModel: viewModel, presentAnimated: presentAnimated, dismissAnimated: dismissAnimated)

        let dismiss = Observable<Never>.deferred { [weak self] in
            guard let self = self else {
                return Observable<Never>.empty()
            }

            return self.presentation.dismiss.execute(dismissAnimated)
                .catchError { _ in return Observable<Never>.empty() }
        }

        // Wait until the dismiss action is enabled before dismissing.
        let dismissWhenEnabled = presentation.dismiss.enabled
            // Observe on the main queue scheduler to avoid a deadlock if this all happens synchronously.
            .observeOn(MainScheduler.asyncInstance)
            .filter { $0 }
            .take(1)
            .whenTrue(subscribeTo: dismiss)

        // When a result is received begin waiting for the dismiss action to be enabled and then dismiss.
        viewModel.result
            .take(1)
            .ignoreElements()
            .andThen(dismissWhenEnabled)
            .takeUntil(presentation.didDismiss)
            // Ensure self is retained until the presented view controller is dismiss so that it can observe the result.
            .untilDisposal(retain: self)
            .subscribe()
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

}
