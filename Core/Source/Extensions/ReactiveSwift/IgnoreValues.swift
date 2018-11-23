import ReactiveSwift
import Result

public extension Signal {

    /// Returns a signal that never sends any values.
    public func ignoreValues() -> Signal<(), Error> {
        return filter { _ in return false }
            .map { _ in return () }
    }

}

public extension SignalProducer {

    /// Returns a signal producer whose signal never sends any values.
    public func ignoreValues() -> SignalProducer<(), Error> {
        return lift { $0.ignoreValues() }
    }

}
