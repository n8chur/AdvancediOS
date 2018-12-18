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
    /// - Parameter getPresenter: A closure that should return the presenting view model's presenter. If nil is
    ///             returned a fatalError will be thrown. This is only optional as a convenience for consumers so that
    ///             they are not forced to guard unwrapping [weak self] when providing the presenter.
    /// - Parameter getViewModel: A closure that is has an input of a presenter and should return the view model to be
    ///             presented. The presented view model is typically created by the presenter.
    /// - Parameter getPresentation: A closure that has an input of the presenter and the view model to be presented,
    ///             and should return a presentation of that view model.
    /// - Parameter getContext: A closure that has an input of the presentation returned from getPresentation, the view
    ///             model to be presented, and a Bool indicating whether the presentation should be animated, and
    ///             returns a presentation context.
    public func makePresent<PresentedViewModel: ViewModel, Presenter, PresentationContextType: PresentationContext>(
        getPresenter: @escaping () -> Presenter?,
        getViewModel: @escaping (Presenter) -> PresentedViewModel,
        getPresentation: @escaping (Presenter, PresentedViewModel) -> PresentationContextType.PresentationType,
        getContext: @escaping (PresentationContextType.PresentationType, PresentedViewModel, _ animated: Bool) -> PresentationContextType
    ) -> Action<Bool, PresentedViewModel, NoError> {
        return Action<Bool, PresentedViewModel, NoError> { (animated: Bool) in
            return SignalProducer<PresentedViewModel, NoError> { (observer, lifetime) in
                guard let presenter = getPresenter() else {
                    fatalError()
                }

                let viewModel = getViewModel(presenter)
                let presentation = getPresentation(presenter, viewModel)
                let context = getContext(presentation, viewModel, animated)

                context.presentation.present.apply(context.presentAnimated)
                    .flatMapError { _ in return SignalProducer<Never, NoError>.empty }
                    .then(SignalProducer(value: viewModel))
                    .take(during: lifetime)
                    .untilDisposal(retain: context)
                    .start(observer)
            }
        }
    }

}
