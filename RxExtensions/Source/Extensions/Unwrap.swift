import RxSwift

public extension ObservableType {

    /// Prevents sending of nil elements and sends elements unwrapped.
    func unwrap<T>() -> Observable<T> where Element == T? {
        return self
            .filter { $0 != nil }
            .map { $0! }
    }

}
