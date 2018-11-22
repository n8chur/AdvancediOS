import ReactiveSwift
import Result

public extension SignalProducer {

    public func untilDisposal(retain object: AnyObject) -> SignalProducer<Value, Error> {
        return on(disposed: {
            _ = object
        })
    }

}
