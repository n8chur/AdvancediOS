import ReactiveSwift
import Result
import Presentations

@testable import Application

class StubHomePresenter: StubDetailPresenter {

    let makeHomeViewModelCall = MutableProperty<HomeViewModel?>(nil)
    let homePresentation = MutableProperty<HomeViewModel?>(nil)

}

extension StubHomePresenter: HomePresenter {

    func makeHomeViewModel() -> HomeViewModel {
        let viewModel = HomeViewModel()
        makeHomeViewModelCall.value = viewModel
        return viewModel
    }

    func homePresentation(of viewModel: HomeViewModel) -> DismissablePresentation {
        homePresentation.value = viewModel
        return DismissablePresentation.stub()
    }

}
