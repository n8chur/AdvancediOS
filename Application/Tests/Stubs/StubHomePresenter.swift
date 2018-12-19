import ReactiveSwift
import Result
import Presentations

@testable import Application

class StubHomePresenter: StubDetailPresenter {

    let homePresentation = MutableProperty<HomeViewModel?>(nil)

}

extension StubHomePresenter: HomePresenter {

    func homePresentation(of viewModel: HomeViewModel) -> DismissablePresentation {
        homePresentation.value = viewModel
        return DismissablePresentation.stub()
    }

}
