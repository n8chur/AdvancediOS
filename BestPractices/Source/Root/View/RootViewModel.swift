import ReactiveSwift
import Result
import Core

class RootViewModel: ViewModel, DetailPresentingViewModel {

    let isActive = MutableProperty(false)

    weak var detailPresenter: DetailPresenter?

    let testText: Property<String?>
    let image = Property(value: Image.n8churLogo.image)
    let presentDetailTitle = Property(value: L10n.Root.PresentDetail.title)

    private(set) lazy var presentDetail = Action<(), (), DetailPresentError> { [weak self] _ in
        return SignalProducer<DetailViewModel, DetailPresentationError> { DetailViewModel() }
            .flatMap(.merge) { viewModel -> SignalProducer<(), DetailPresentationError> in
                guard let presenter = self?.detailPresenter else {
                    fatalError()
                }

                return presenter.detailPresentation(of: viewModel)
            }
            .mapError { _ in return .unknown }
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
