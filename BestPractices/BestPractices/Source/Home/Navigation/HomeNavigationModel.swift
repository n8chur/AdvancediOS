import ReactiveSwift
import Core

class HomeNavigationModel: ViewModel, HomePresentingViewModel {

    let isActive = MutableProperty<Bool>(false)

    private(set) lazy var presentHome = makePresentHome()

    weak var homePresenter: HomePresenter?

    let tabBarItemTitle = Property(value: L10n.HomeNavigation.TabBarItem.title)

    init() { }

}
