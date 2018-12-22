import RxSwift
import Action
import Presentations

class StubPresentingViewModel<Presenter: AnyObject>: PresentingViewModel {

    let isActive = Variable(true)

    weak var presenter: Presenter?

    let context = Variable<Bool?>(nil)

    private(set) lazy var presentViewModel: Action<Bool, StubViewModel> = makePresentAction { [unowned self] animated -> DismissablePresentationContext<StubViewModel> in
            self.context.value = animated
            return DismissablePresentationContext.stub()
        }

}
