import ReactiveSwift

class HomeNavigationModel: TabBarChildViewModel, HomePresentingViewModel {

    let isActive = MutableProperty<Bool>(false)

    let tabBarItemTitle = Property(value: L10n.HomeNavigation.TabBarItem.title)

    private(set) lazy var presentHome = makePresentHome()

    weak var homePresenter: HomePresenter?

    init() { }

}

protocol HomeNavigationModelFactoryProtocol: HomeViewModelFactoryProtocol { }

extension HomeNavigationModelFactoryProtocol {

    func makeHomeNavigationModel() -> HomeNavigationModel {
        return HomeNavigationModel()
    }

}
