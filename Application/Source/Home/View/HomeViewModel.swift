import ReactiveSwift
import Result
import Presentations
import RxExtensions
import Core

class HomeViewModel: ViewModel, DetailPresentingViewModel {

    let isActive = MutableProperty(false)

    weak var detailPresenter: DetailPresenter?

    /// Example text that will be updated asynchronously when isActive becomes true.
    let testText: Property<String?>
    let image = Property(value: Image.n8churLogo.image)
    let presentDetailTitle = Property(value: L10n.Home.PresentDetail.title)

    private(set) lazy var presentDetail = makePresentDetail(withFactory: detailFactory)

    private let backgroundScheduler = QueueScheduler(qos: .background, name: "RootViewModel.backgroundScheduler")

    init(detailFactory: DetailViewModelFactoryProtocol) {
        self.detailFactory = detailFactory

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

    private let detailFactory: DetailViewModelFactoryProtocol

}

protocol HomeViewModelFactoryProtocol: DetailViewModelFactoryProtocol {
    func makeHomeViewModel() -> HomeViewModel
}

extension HomeViewModelFactoryProtocol {

    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(detailFactory: self)
    }

}
