import ReactiveSwift
import Result
import Presentations

@testable import Application

class StubDetailPresenter: StubSelectionPresenter {

    let makeDetailViewModelCall = MutableProperty<DetailViewModel?>(nil)
    let detailPresentation = MutableProperty<DetailViewModel?>(nil)

}

extension StubDetailPresenter: DetailPresenter {

    func makeDetailViewModel() -> DetailViewModel {
        let viewModel = DetailViewModel()
        makeDetailViewModelCall.value = viewModel
        return viewModel
    }

    func detailPresentation(of viewModel: DetailViewModel) -> DismissablePresentation {
        detailPresentation.value = viewModel
        return DismissablePresentation.stub()
    }

}
