import ReactiveSwift

class DetailNavigationModel: TabBarChildViewModel, DetailPresentingViewModel {

    let isActive = MutableProperty<Bool>(false)

    let tabBarItemTitle = Property(value: L10n.DetailNavigation.TabBarItem.title)

    private(set) lazy var presentDetail = makePresentDetail(withFactory: detailViewModelFactory)

    weak var detailPresenter: DetailPresenter?

    init(detailViewModelFactory: DetailViewModelFactoryProtocol) {
        self.detailViewModelFactory = detailViewModelFactory
    }

    private let detailViewModelFactory: DetailViewModelFactoryProtocol

}

protocol DetailNavigationModelFactoryProtocol: DetailViewModelFactoryProtocol { }

extension DetailNavigationModelFactoryProtocol {

    func makeDetailNavigationModel() -> DetailNavigationModel {
        return DetailNavigationModel(detailViewModelFactory: self)
    }

}

class DetailNavigationModelFactory: DetailNavigationModelFactoryProtocol { }
