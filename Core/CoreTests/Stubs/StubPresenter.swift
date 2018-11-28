import ReactiveSwift
import Result
import Core

class StubPresenter: Presenter {

    let setupPresenters = MutableProperty<ViewModel?>(nil)
    let getContext = MutableProperty<ViewModel?>(nil)

    func makePresentation(of viewModel: ViewModel, context: DismissablePresentationContext) -> SignalProducer<Never, NoError> {
        return makePresentation(
            of: viewModel,
            setupPresenters: { [unowned self] viewModel in
                self.setupPresenters.value = viewModel
            },
            getContext: { [unowned self] viewModel in
                self.getContext.value = viewModel
                return context
            })
    }

}
