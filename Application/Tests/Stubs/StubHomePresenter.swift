import RxSwift
import RxCocoa
import Presentations

@testable import Application

class StubHomePresenter: StubDetailPresenter {

    let homePresentation = BehaviorRelay<HomeViewModel?>(value: nil)

}

extension StubHomePresenter: HomePresenter {

    func homePresentation(of viewModel: HomeViewModel) -> DismissablePresentation {
        homePresentation.accept(viewModel)
        return DismissablePresentation.stub()
    }

}
