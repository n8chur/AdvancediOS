import RxSwift

public extension ObservableType {

    /// Retains the provided object until the receiver is disposed.
    ///
    /// The object will only begin being retained once the returned observable is observed.
    func untilDisposal(retain object: AnyObject) -> Observable<Self.Element> {
        return Observable<Self.Element>.create { [weak object] observer in
            guard let object = object else {
                return self.subscribe(observer)
            }

            return self
                .do(onDispose: { _ = object })
                .subscribe(observer)
        }
    }

}
