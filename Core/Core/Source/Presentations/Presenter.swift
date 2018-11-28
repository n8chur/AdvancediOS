import ReactiveSwift
import Result

public protocol Presenter { }

public extension Presenter {

    public func makePresentation<PresentedViewModel, Context: DismissablePresentationContext>(
        of viewModel: PresentedViewModel,
        setupPresenters: ((PresentedViewModel) -> Void)? = nil,
        getContext: @escaping (PresentedViewModel) -> Context?
    ) -> SignalProducer<Never, NoError> {
        let context = SignalProducer<Context, NoError> { () -> Context in
            setupPresenters?(viewModel)

            guard let context = getContext(viewModel) else {
                fatalError()
            }

            return context
        }

        return context.flatMap(.merge) { context -> SignalProducer<Never, NoError> in
            return context.presentation.present.apply(context.presentAnimated)
                .flatMapError { _ in return SignalProducer<Never, NoError>.empty }
                .untilDisposal(retain: context)
        }
    }

}
