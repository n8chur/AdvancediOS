import RxSwift
import Presentations

class StubResultViewModel: ResultViewModel {

    typealias Result = ()

    let isActive = Variable(true)

    let resultSubject = PublishSubject<()>()

    private(set) lazy var result = resultSubject.asObservable()

}
