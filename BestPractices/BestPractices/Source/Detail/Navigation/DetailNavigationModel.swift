import ReactiveSwift
import Core

class DetailNavigationModel: TabBarChildViewModel, DetailPresentingViewModel {

    let isActive = MutableProperty<Bool>(false)

    let tabBarItemTitle = Property(value: L10n.DetailNavigation.TabBarItem.title)

    private(set) lazy var presentDetail = makePresentDetail()

    weak var detailPresenter: DetailPresenter?

    init() { }

}
