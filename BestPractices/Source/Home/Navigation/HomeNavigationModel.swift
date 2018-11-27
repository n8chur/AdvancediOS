import ReactiveSwift
import Core

class HomeNavigationModel: ViewModel {

    let isActive = MutableProperty<Bool>(false)

    let homeViewModel: HomeViewModel

    init() {
        homeViewModel = HomeViewModel()
    }

}
