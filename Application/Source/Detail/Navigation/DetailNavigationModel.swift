import ReactiveSwift

class DetailNavigationModel: TabBarChildViewModel, DetailPresentingViewModel {

    let isActive = MutableProperty<Bool>(false)

    let tabBarItemTitle = Property(value: L10n.DetailNavigation.TabBarItem.title)

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

class DetailNavigationModelFactory: DetailNavigationModelFactoryProtocol { }
