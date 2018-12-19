import ReactiveSwift

class HomeNavigationModel: TabBarChildViewModel, HomePresentingViewModel {

    let isActive = MutableProperty<Bool>(false)

    let tabBarItemTitle = Property(value: L10n.HomeNavigation.TabBarItem.title)

    private(set) lazy var presentHome = makePresentHome(withFactory: homeFactory)

    weak var homePresenter: HomePresenter?

    init(homeFactory: HomeViewModelFactoryProtocol) {
        self.homeFactory = homeFactory
    }

    private let homeFactory: HomeViewModelFactoryProtocol

}

protocol HomeNavigationModelFactoryProtocol: HomeViewModelFactoryProtocol {
    func makeHomeNavigationModel() -> HomeNavigationModel
}

extension HomeNavigationModelFactoryProtocol {

    func makeHomeNavigationModel() -> HomeNavigationModel {
        return HomeNavigationModel(homeFactory: self)
    }

}

class HomeNavigationModelFactory: HomeNavigationModelFactoryProtocol { }
