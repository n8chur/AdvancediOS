import RxSwift

public extension ObservableType where Self.E == Bool {

    /// Returns an observer that will subscribe to the trueObservable when the receiver sends true, and will subscribe
    /// to the falseObservable when the receiver sends false.
    ///
    /// When the active observable sends a new value, the signal that was previously subscribed to will be unsubscribed.
    ///
    /// If the same value is sent twice in a row the signal will be resubscribed to. Add a distince until changed to the
    /// receiver before using this operator to avoid this behavior.
    ///
    /// The returned Observable completes when the receiver completes.
    ///
    /// - Parameter trueObservable: The observable that will be subscribed to when the receiver sends true.
    /// - Parameter falseObservable: The observable that will be subscribed to when the receiver sends false.
    public func whenTrue<Element>(subscribeTo trueObservable: Observable<Element>, otherwise falseObservable: Observable<Element> = Observable<Element>.empty()) -> Observable<Element> {
        return flatMapLatest { isActive in
            return isActive ? trueObservable : falseObservable
        }
    }

}
