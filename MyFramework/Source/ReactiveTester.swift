import ReactiveSwift
import Result

public class ReactiveTester {
    public class func signalProducer() -> SignalProducer<String, NoError> {
        return SignalProducer.timer(interval: DispatchTimeInterval.milliseconds(500), on: QueueScheduler.main)
            .take(first: 1)
            .map { _ in
                return "This is a test"
            }
    }
}
