import ReactiveSwift
import Result
import Presentations

@testable import Application

class StubDetailPresenter: StubSelectionPresenter {

    let detailPresentation = MutableProperty<DetailViewModel?>(nil)

}

extension StubDetailPresenter: DetailPresenter {

    func detailPresentation(of viewModel: DetailViewModel) -> DismissablePresentation {
        detailPresentation.value = viewModel
        return DismissablePresentation.stub()
    }

}
