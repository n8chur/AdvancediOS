import ReactiveSwift
import Result
import Core

class RootViewModel: ViewModel {

    let isActive = MutableProperty<Bool>(false)

    let testText: Property<String?>

    let selectDetailsTitle = Property(value: L10n.Root.SelectDetails.title)

    let image = Property(value: Image.n8churLogo.image)

    let selectDetails = Action<(), DetailViewModel, NoError> { _ in
        return SignalProducer(value: DetailViewModel())
    }

    private let backgroundScheduler = QueueScheduler(qos: .background, name: "RootViewModel")

    init() {
        let testTextInternalProducer = SignalProducer
            .timer(interval: DispatchTimeInterval.milliseconds(500), on: backgroundScheduler)
            .take(first: 1)
            .map { _ in
                return Optional.some(L10n.Root.testText)
            }

        let testTextProducer = isActive.producer
            .whenTrue(subscribeTo: testTextInternalProducer)

        testText = Property(initial: nil, then: testTextProducer)
    }

}
