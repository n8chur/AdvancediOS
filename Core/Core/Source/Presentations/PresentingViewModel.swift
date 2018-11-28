import ReactiveSwift
import Result

public protocol PresentingViewModel: ViewModel { }

public extension PresentingViewModel {
    public func makePresent<PresentedViewModel: ViewModel, Presenter>(
        getPresenter: @escaping () -> Presenter?,
        getViewModel: @escaping (Presenter) -> PresentedViewModel,
        setupViewModel: ((PresentedViewModel) -> Void)? = nil,
        getPresentationProducer: @escaping (Presenter, PresentedViewModel) -> SignalProducer<Never, NoError>
    ) -> Action<(), Never, NoError> {
        return Action<(), Never, NoError> { _ in
            return SignalProducer<Never, NoError> { (observer, lifetime) in
                guard let presenter = getPresenter() else {
                    fatalError()
                }

                let viewModel = getViewModel(presenter)

                setupViewModel?(viewModel)

                let presentationProducer = getPresentationProducer(presenter, viewModel)

                presentationProducer
                    .take(during: lifetime)
                    .start(observer)
            }
        }
    }
}
