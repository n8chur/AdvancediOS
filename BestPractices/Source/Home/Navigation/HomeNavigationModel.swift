import ReactiveSwift
import Core

class HomeNavigationModel: ViewModel, HomePresentingViewModel {

    let isActive = MutableProperty<Bool>(false)

    private(set) lazy var presentHome = makePresentHome()

    weak var homePresenter: HomePresenter?

    init() { }

}
