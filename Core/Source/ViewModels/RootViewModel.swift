import ReactiveSwift
import Result

public class RootViewModel: ViewModel {

    public let isActive = MutableProperty<Bool>(false)

    public let testText: Property<String?>

    let backgroundScheduler = QueueScheduler(qos: .background, name: "RootViewModel")

    public init() {
        let testTextInternalSignalProducer = SignalProducer
            .timer(interval: DispatchTimeInterval.milliseconds(500), on: backgroundScheduler)
            .take(first: 1)
            .map { _ in
                return Optional.some("It works!")
            }

        let testTextSignalProducer = isActive.producer
            .whenTrue(subscribeTo: testTextInternalSignalProducer)

        testText = Property(initial: nil, then: testTextSignalProducer)
    }

}
