import RxCocoa
import RxSwift
import Presentations

class StubResultViewModel: ResultViewModel {

    typealias Result = ()

    let isActive = BehaviorRelay(value: true)

    let resultSubject = PublishSubject<()>()

    private(set) lazy var result = resultSubject.asObservable()

}
