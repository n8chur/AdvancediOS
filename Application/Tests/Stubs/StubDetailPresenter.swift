import ReactiveSwift
import Result
import Presentations

@testable import Application

class StubDetailPresenter: StubSelectionPresenter {

    let (makeDetailViewModelSignal, makeDetailViewModelObserver) = Signal<DetailViewModel, NoError>.pipe()
    let (detailPresentationContextSignal, detailPresentationContextObserver) = Signal<DetailViewModel, NoError>.pipe()

}

extension StubDetailPresenter: DetailPresenter {

    func makeDetailViewModel() -> DetailViewModel {
        let viewModel = DetailViewModel()
        makeDetailViewModelObserver.send(value: viewModel)
        return viewModel
    }

    func detailPresentationContext(of viewModel: DetailViewModel) -> DismissablePresentationContext {
        detailPresentationContextObserver.send(value: viewModel)
        return DismissablePresentationContext.stub()
    }

}
