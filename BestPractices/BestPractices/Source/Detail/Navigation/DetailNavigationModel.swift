import ReactiveSwift
import Core

class DetailNavigationModel: TabBarChildViewModel, DetailPresentingViewModel {

    let isActive = MutableProperty<Bool>(false)

    let tabBarItemTitle = Property(value: L10n.DetailNavigation.TabBarItem.title)

    private(set) lazy var presentDetail = makePresentDetail()

    weak var detailPresenter: DetailPresenter?

    init() { }

}

protocol DetailNavigationModelFactory: DetailViewModelFactoryProtocol { }

extension DetailNavigationModelFactory {

    func makeDetailNavigationModel() -> DetailNavigationModel {
        return DetailNavigationModel()
    }

}
