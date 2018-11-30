import ReactiveSwift
import Result

public extension Signal {

    /// Retains the provided object until the receiver is disposed.
    public func untilDisposal(retain object: AnyObject) -> Signal<Value, Error> {
        return signal.on(disposed: {
            _ = object
        })
    }

}

public extension SignalProducer {

    /// Retains the provided object until the receiver is disposed.
    ///
    /// Note that the object must be retained until the signal has started.
    public func untilDisposal(retain object: AnyObject) -> SignalProducer<Value, Error> {
        return lift { [weak object] signal in
            guard let object = object else {
                return signal
            }

            return signal.untilDisposal(retain: object)
        }
    }

}
