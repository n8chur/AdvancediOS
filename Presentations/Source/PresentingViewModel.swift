import ReactiveSwift
import Result

public protocol PresentingViewModel: ViewModel { }

public extension PresentingViewModel {

    /// Creates an action suitable for presenting a view model.
    ///
    /// Its execution signal should send the presented view model and then complete after the presentation has finished.
    ///
    /// The returned action should be applied with an Bool that indicates whether or not the presentation should be
    /// animated.
    ///
    /// - Parameter context: A closure that returns a presentation context or nil if the context failed to be created.
    ///             If nil is returned, this action will have no effect.
    public func makePresentAction<PresentationContextType: PresentationContext>(
        withContext context: @escaping (_ animated: Bool) -> PresentationContextType?
    ) -> Action<Bool, PresentationContextType.ViewModelType, NoError> {
        return Action<Bool, PresentationContextType.ViewModelType, NoError> { (animated: Bool) in
            return SignalProducer<PresentationContextType.ViewModelType, NoError> { (observer, lifetime) in
                guard let context = context(animated) else {
                    observer.sendCompleted()
                    return
                }

                context.presentation.present.apply(context.presentAnimated)
                    .flatMapError { _ in return SignalProducer<Never, NoError>.empty }
                    .then(SignalProducer(value: context.viewModel))
                    .take(during: lifetime)
                    .untilDisposal(retain: context)
                    .start(observer)
            }
        }
    }

}
