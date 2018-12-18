import ReactiveSwift
import Result
import Presentations

class StubPresentingViewModel<Presenter: AnyObject>: PresentingViewModel {

    let isActive = MutableProperty(true)

    weak var presenter: Presenter?

    let context = MutableProperty<Bool?>(nil)

    private(set) lazy var presentViewModel = makePresentAction { [unowned self] animated -> DismissablePresentationContext<StubViewModel> in
        self.context.value = animated
        return DismissablePresentationContext.stub()
    }

}
