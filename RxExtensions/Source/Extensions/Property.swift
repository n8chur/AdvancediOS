import RxCocoa
import RxSwift

// Adapted from https://github.com/ReactiveX/RxSwift/issues/1236#issue-226036269

// An Immutable BehaviorRelay
public final class Property<Element>: ObservableType {

    public convenience init(_ value: Element) {
        self.init(BehaviorRelay(value: value))
    }

    public init(_ relay: BehaviorRelay<Element>) {
        self.relay = relay
    }

    public convenience init(_ observable: Observable<Element>, initial: Element) {
        self.init(initial)

        observable
            .bind(to: relay)
            .disposed(by: disposeBag)
    }

    public var value: Element {
        return relay.value
    }

    public func asObservable() -> Observable<Element> {
        return relay.asObservable()
    }

    public func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return relay.subscribe(observer)
    }

    private let relay: BehaviorRelay<Element>
    private let disposeBag = DisposeBag()
}

public extension BehaviorRelay {
    public func asProperty() -> Property<E> {
        return Property(self)
    }
}
