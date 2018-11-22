import ReactiveSwift
import Result

public extension Signal {

    public func ignoreValues() -> Signal<(), Error> {
        return filter { _ in return false }
            .map { _ in return () }
    }

}

public extension SignalProducer {

    public func ignoreValues() -> SignalProducer<(), Error> {
        return lift { $0.ignoreValues() }
    }

}
