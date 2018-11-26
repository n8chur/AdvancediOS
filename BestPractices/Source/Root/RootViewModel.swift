import ReactiveSwift
import Result
import Core

class RootViewModel: ViewModel, DetailPresentingViewModel {

    let isActive = MutableProperty(false)

    weak var detailPresenter: DetailPresenter?

    /// Example text that will be updated asynchonously when isActive becomes true.
    let testText: Property<String?>
    let image = Property(value: Image.n8churLogo.image)
    let presentDetailTitle = Property(value: L10n.Root.PresentDetail.title)

    private(set) lazy var presentDetail = Action<(), Never, NoError> { [weak self] _ in
        let viewModel = SignalProducer<DetailViewModel, NoError> { DetailViewModel() }

        return viewModel.flatMap(.merge) { viewModel -> SignalProducer<Never, NoError> in
            guard let presenter = self?.detailPresenter else {
                fatalError()
            }

            return presenter.detailPresentation(of: viewModel)
        }
    }

    private let backgroundScheduler = QueueScheduler(qos: .background, name: "RootViewModel.backgroundScheduler")

    init() {
        let testTextInternalProducer = SignalProducer
            // Add a delay to simulate a network operation.
            .timer(interval: DispatchTimeInterval.milliseconds(50), on: backgroundScheduler)
            .take(first: 1)
            .map { _ in
                return Optional.some(L10n.Root.testText)
            }

        let testTextProducer = isActive.producer
            .whenTrue(subscribeTo: testTextInternalProducer)

        testText = Property(initial: nil, then: testTextProducer)
    }

}
