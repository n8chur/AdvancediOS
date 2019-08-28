import RxSwift
import Action

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
    func makePresentAction<Input, PresentationContextType: PresentationContext>(
        withContext context: @escaping (Input) -> PresentationContextType?
    ) -> Action<Input, PresentationContextType.ViewModelType> {
        return Action<Input, PresentationContextType.ViewModelType> { input in
            return Observable<PresentationContextType.ViewModelType>.create { observer in
                guard let context = context(input) else {
                    observer.onCompleted()
                    return SingleAssignmentDisposable()
                }

                return context.presentation.present.execute(context.presentAnimated)
                    .catchError { _ in return Observable<Never>.empty() }
                    .ignoreElements()
                    .andThen(Observable.just(context.viewModel))
                    .untilDisposal(retain: context)
                    .subscribe(observer)
            }
        }
    }

}
