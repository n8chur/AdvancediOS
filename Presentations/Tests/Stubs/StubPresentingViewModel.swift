import ReactiveSwift
import Result
import Presentations

class StubPresentingViewModel<Presenter: AnyObject>: PresentingViewModel {

    let isActive = MutableProperty(true)

    weak var presenter: Presenter?

    let getPresenter = MutableProperty<Presenter?>(nil)
    let getViewModel = MutableProperty<(Presenter, StubViewModel)?>(nil)
    let getPresentation = MutableProperty<(Presenter, StubViewModel, DismissablePresentation)?>(nil)
    let getContext = MutableProperty<(DismissablePresentation, StubViewModel, Bool)?>(nil)

    private(set) lazy var presentViewModel = makePresent(
        getPresenter: { [unowned self] () -> Presenter? in
            let presenter = self.presenter
            self.getPresenter.value = presenter
            return presenter
        },
        getViewModel: { [unowned self] presenter -> StubViewModel in
            let viewModel = StubViewModel()
            self.getViewModel.value = (presenter, viewModel)
            return viewModel
        },
        getPresentation: { [unowned self] (presenter, viewModel) -> DismissablePresentation in
            let presentation = DismissablePresentation.stub()
            self.getPresentation.value = (presenter, viewModel, presentation)
            return presentation
        },
        getContext: { [unowned self] (presentation, viewModel, animated) -> DismissablePresentationContext in
            self.getContext.value = (presentation, viewModel, animated)
            return DismissablePresentationContext.stub(withPresentation: presentation)
        })

}
