import ReactiveSwift
import Result

@testable import Application

class StubHomePresentingViewModel: HomePresentingViewModel {

    let setupViewModel = MutableProperty<HomeViewModel?>(nil)

    weak var homePresenter: HomePresenter?

    private(set) lazy var presentHome: Action<Bool, HomeViewModel, NoError> = makePresentHome(withFactory: factory) { [unowned self] viewModel in
        self.setupViewModel.value = viewModel
    }

    let isActive = MutableProperty<Bool>(false)

    let factory = StubHomeViewModelFactory()

}

class StubHomeViewModelFactory: HomeViewModelFactoryProtocol {

    let makeViewModel = MutableProperty<HomeViewModel?>(nil)

    func makeHomeViewModel() -> HomeViewModel {
        let viewModel = HomeViewModel(detailFactory: self)
        makeViewModel.value = viewModel
        return viewModel
    }
}
