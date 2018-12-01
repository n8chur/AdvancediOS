import ReactiveSwift
import Result
import Presentations

class StubResultViewModel: ResultViewModel {

    typealias Result = Bool

    let isActive = MutableProperty(true)

    let (result, resultObserver) = Signal<Bool, NoError>.pipe()

}
