import RxCocoa
import Presentations

@testable import Application

class StubDetailPresenter: StubSelectionPresenter {

    let detailPresentation = BehaviorRelay<DetailViewModel?>(value: nil)

}

extension StubDetailPresenter: DetailPresenter {

    func foodTablePresentation(of viewModel: FoodTableViewModel) -> DismissablePresentation {
        return DismissablePresentation.stub()
    }

    func detailPresentation(of viewModel: DetailViewModel) -> DismissablePresentation {
        detailPresentation.accept(viewModel)
        return DismissablePresentation.stub()
    }

}
