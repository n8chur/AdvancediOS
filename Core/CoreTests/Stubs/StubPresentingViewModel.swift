import ReactiveSwift
import Result
import Core

class StubPresentingViewModel<Presenter: AnyObject>: PresentingViewModel {

    let isActive = MutableProperty(true)

    weak var presenter: Presenter?

    let getPresenter = MutableProperty<Presenter?>(nil)
    let getViewModel = MutableProperty<(Presenter, StubViewModel)?>(nil)
    let setupViewModel = MutableProperty<StubViewModel?>(nil)
    let getPresentationProducer = MutableProperty<(Presenter, StubViewModel)?>(nil)

    private(set) lazy var presentViewModel = makePresent(
        getPresenter: { [unowned self] () -> Presenter? in
            let presenter = self.presenter
            self.getPresenter.value = presenter
            return presenter
        },
        getViewModel: { [unowned self] (presenter) in
            let viewModel = StubViewModel()
            self.getViewModel.value = (presenter, viewModel)
            return viewModel
        },
        setupViewModel: { [unowned self] viewModel in
            self.setupViewModel.value = viewModel
        },
        getPresentationProducer: { [unowned self] (presenter, viewModel) in
            self.getPresentationProducer.value = (presenter, viewModel)
            return SignalProducer<Never, NoError>.empty
        })

}
