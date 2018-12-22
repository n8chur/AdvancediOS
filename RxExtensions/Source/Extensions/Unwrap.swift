import RxSwift

public extension ObservableType {

    /// Prevents sending of nil elements and sends elements unwrapped.
    public func unwrap<Element>() -> Observable<Element> where E == Element? {
        return self
            .filter { $0 != nil }
            .map { $0! }
    }

}
