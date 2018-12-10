import ReactiveSwift
import Result
import Presentations

@testable import Application

class StubHomePresenter: StubDetailPresenter {

    let makeHomeViewModelCall = MutableProperty<HomeViewModel?>(nil)
    let homePresentationContext = MutableProperty<HomeViewModel?>(nil)

}

extension StubHomePresenter: HomePresenter {

    func makeHomeViewModel() -> HomeViewModel {
        let viewModel = HomeViewModel()
        makeHomeViewModelCall.value = viewModel
        return viewModel
    }

    func homePresentationContext(of viewModel: HomeViewModel) -> DismissablePresentationContext {
        homePresentationContext.value = viewModel
        return DismissablePresentationContext.stub()
    }

}
