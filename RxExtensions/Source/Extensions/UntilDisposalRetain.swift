import RxSwift

public extension ObservableType {

    /// Retains the provided object until the receiver is disposed.
    ///
    /// The object will only begin being retained once the returned observable is observed.
    public func untilDisposal(retain object: AnyObject) -> Observable<Self.E> {
        return Observable<Self.E>.create { [weak object] observer in
            guard let object = object else {
                return self.subscribe(observer)
            }

            return self
                .do(onDispose: { _ = object })
                .subscribe(observer)
        }
    }

}
