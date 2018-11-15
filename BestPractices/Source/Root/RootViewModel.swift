import ReactiveSwift
import Result
import Core

class RootViewModel: ViewModel {

    let isActive = MutableProperty<Bool>(false)

    let testText: Property<String?>

    private let backgroundScheduler = QueueScheduler(qos: .background, name: "RootViewModel")

    init() {
        let testTextInternalProducer = SignalProducer
            .timer(interval: DispatchTimeInterval.milliseconds(500), on: backgroundScheduler)
            .take(first: 1)
            .map { _ in
                return Optional.some("It works!")
            }

        let testTextProducer = isActive.producer
            .whenTrue(subscribeTo: testTextInternalProducer)

        testText = Property(initial: nil, then: testTextProducer)
    }

}
