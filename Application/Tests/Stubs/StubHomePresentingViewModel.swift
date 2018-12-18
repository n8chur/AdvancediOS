import ReactiveSwift
import Result

@testable import Application

class StubHomePresentingViewModel: HomePresentingViewModel {

    let setupViewModel = MutableProperty<HomeViewModel?>(nil)

    weak var homePresenter: HomePresenter?

    private(set) lazy var presentHome: Action<Bool, HomeViewModel, NoError> = makePresentHome { [unowned self] viewModel in
        self.setupViewModel.value = viewModel
    }

    let isActive = MutableProperty<Bool>(false)

}
