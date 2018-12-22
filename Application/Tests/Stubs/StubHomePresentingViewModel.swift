import RxSwift
import RxCocoa
import Action

@testable import Application

class StubHomePresentingViewModel: HomePresentingViewModel {

    let setupViewModel = BehaviorRelay<HomeViewModel?>(value: nil)

    weak var homePresenter: HomePresenter?

    private(set) lazy var presentHome: Action<Bool, HomeViewModel> = makePresentHome(withFactory: factory) { [unowned self] viewModel in
        self.setupViewModel.accept(viewModel)
    }

    let isActive = BehaviorRelay<Bool>(value: false)

    let factory = StubHomeViewModelFactory()

}

class StubHomeViewModelFactory: HomeViewModelFactoryProtocol {

    let makeViewModel = BehaviorRelay<HomeViewModel?>(value: nil)

    func makeHomeViewModel() -> HomeViewModel {
        let viewModel = HomeViewModel(detailFactory: self)
        makeViewModel.accept(viewModel)
        return viewModel
    }
}
