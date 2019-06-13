import RxSwift
import RxCocoa
import RxExtensions

class DetailNavigationModel: TabBarChildViewModel, DetailPresentingViewModel {

    let isActive = BehaviorRelay<Bool>(value: false)

    let tabBarItemTitle = Property(L10n.DetailNavigation.TabBarItem.title)

    private(set) lazy var presentDetail = makePresentDetail(withFactory: detailFactory)

    weak var detailPresenter: DetailPresenter?

    init(detailFactory: DetailViewModelFactoryProtocol) {
        self.detailFactory = detailFactory
    }

    private let detailFactory: DetailViewModelFactoryProtocol

}

protocol DetailNavigationModelFactoryProtocol: DetailViewModelFactoryProtocol {
    func makeDetailNavigationModel() -> DetailNavigationModel
}

extension DetailNavigationModelFactoryProtocol {

    func makeDetailNavigationModel() -> DetailNavigationModel {
        return DetailNavigationModel(detailFactory: self)
    }

}
