import ReactiveSwift

class HomeNavigationModel: TabBarChildViewModel, HomePresentingViewModel {

    let isActive = MutableProperty<Bool>(false)

    let tabBarItemTitle = Property(value: L10n.HomeNavigation.TabBarItem.title)

    private(set) lazy var presentHome = makePresentHome(withFactory: homeViewModelFactory)

    weak var homePresenter: HomePresenter?

    init(homeViewModelFactory: HomeViewModelFactoryProtocol) {
        self.homeViewModelFactory = homeViewModelFactory
    }

    private let homeViewModelFactory: HomeViewModelFactoryProtocol

}

protocol HomeNavigationModelFactoryProtocol: HomeViewModelFactoryProtocol { }

extension HomeNavigationModelFactoryProtocol {

    func makeHomeNavigationModel() -> HomeNavigationModel {
        return HomeNavigationModel(homeViewModelFactory: self)
    }

}

class HomeNavigationModelFactory: HomeNavigationModelFactoryProtocol { }
