import Presentations
import RxSwift
import RxCocoa
import RxExtensions
import Core

class HomeViewModel: ViewModel, DetailPresentingViewModel {

    let isActive = BehaviorRelay(value: false)

    weak var detailPresenter: DetailPresenter?

    /// Example text that will be updated asynchronously when isActive becomes true.
    let testText: Property<String?>
    let image = Property(Image.n8churLogo.image)
    let presentDetailTitle = Property(L10n.Home.PresentDetail.title)

    private(set) lazy var presentDetail = makePresentDetail(withFactory: detailFactory)

    private let backgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .background)

    init(detailFactory: DetailViewModelFactoryProtocol) {
        self.detailFactory = detailFactory

        let testTextInternalObserver = Observable<UInt>
            // Add a delay to simulate a network operation.
            .timer(RxTimeInterval(0.5), scheduler: backgroundScheduler)
            .take(1)
            .map { _ -> String? in
                return L10n.Home.testText
            }

        let testTextObserver = isActive.asObservable()
            .whenTrue(subscribeTo: testTextInternalObserver)

        testText = Property(testTextObserver, initial: nil)
    }

    private let detailFactory: DetailViewModelFactoryProtocol

    private let disposeBag = DisposeBag()

}

protocol HomeViewModelFactoryProtocol: DetailViewModelFactoryProtocol {
    func makeHomeViewModel() -> HomeViewModel
}

extension HomeViewModelFactoryProtocol {

    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(detailFactory: self)
    }

}
