import ReactiveSwift
import Result
import Presentations
import ReactiveExtensions
import Core

class HomeViewModel: ViewModel, DetailPresentingViewModel {

    let isActive = MutableProperty(false)

    weak var detailPresenter: DetailPresenter?

    /// Example text that will be updated asynchonously when isActive becomes true.
    let testText: Property<String?>
    let image = Property(value: Image.n8churLogo.image)
    let presentDetailTitle = Property(value: L10n.Home.PresentDetail.title)

    private(set) lazy var presentDetail = makePresentDetail()

    private let backgroundScheduler = QueueScheduler(qos: .background, name: "RootViewModel.backgroundScheduler")

    init() {
        let testTextInternalProducer = SignalProducer
            // Add a delay to simulate a network operation.
            .timer(interval: DispatchTimeInterval.milliseconds(50), on: backgroundScheduler)
            .take(first: 1)
            .map { _ in
                return Optional.some(L10n.Home.testText)
            }

        let testTextProducer = isActive.producer
            .whenTrue(subscribeTo: testTextInternalProducer)

        testText = Property(initial: nil, then: testTextProducer)
    }

}

protocol HomeViewModelFactoryProtocol: DetailViewModelFactoryProtocol { }

extension HomeViewModelFactoryProtocol {

    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }

}
