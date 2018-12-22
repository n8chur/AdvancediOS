import RxSwift
import RxCocoa
import Action
import Presentations

class StubPresentingViewModel<Presenter: AnyObject>: PresentingViewModel {

    let isActive = BehaviorRelay(value: true)

    weak var presenter: Presenter?

    let context = BehaviorRelay<Bool?>(value: nil)

    private(set) lazy var presentViewModel: Action<Bool, StubViewModel> = makePresentAction { [unowned self] animated -> DismissablePresentationContext<StubViewModel> in
            self.context.accept(animated)
            return DismissablePresentationContext.stub()
        }

}
