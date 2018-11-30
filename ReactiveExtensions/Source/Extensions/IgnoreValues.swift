import ReactiveSwift
import Result

public extension Signal {

    /// Returns a signal that never sends any values.
    public func ignoreValues() -> Signal<Never, Error> {
        return flatMap(.merge) { _ in return Signal<Never, Error>.empty }
    }

}

public extension SignalProducer {

    /// Returns a signal producer whose signal never sends any values.
    public func ignoreValues() -> SignalProducer<Never, Error> {
        return lift { $0.ignoreValues() }
    }

}
