import ReactiveSwift
import Result

public extension SignalProducer where Value == Bool, Error == NoError {

    /// Returns a signal producer that will subscribe to the trueSignalProducer when the reciever sends true, and will
    /// subscribe to the falseSignalProducer when the reciever sends false.
    ///
    /// When the active signal sends a new value, the signal that was previously subscribed to will be disposed of.
    ///
    /// If the same value is sent twice in a row the signal will be resubscribed to.
    ///
    /// - Parameter trueSignalProducer: The signal producer that will be subscribed to when the receiver sends true.
    /// - Parameter falseSignalProducer: The signal producer that will be subscribed to when the receiver sends false.
    public func whenTrue<V, E>(subscribeTo trueSignalProducer: SignalProducer<V, E>, otherwise falseSignalProducer: SignalProducer<V, E> = SignalProducer<V, E>.empty) -> SignalProducer<V, E> {
        return map({ isActive in
                return isActive ? trueSignalProducer : falseSignalProducer
            })
            .flatten(.latest)
    }

}
