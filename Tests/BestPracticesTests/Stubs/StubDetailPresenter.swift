import ReactiveSwift
import Result

@testable import BestPractices

class StubDetailPresenter {

    let (makeViewModelSignal, makeViewModelObserver) = Signal<DetailViewModel, NoError>.pipe()
    let (presentationViewModelSignal, presentationViewModelObserver) = Signal<DetailViewModel, NoError>.pipe()

}

extension StubDetailPresenter: DetailPresenter {

    func makeDetailViewModel() -> DetailViewModel {
        let viewModel = DetailViewModel()
        makeViewModelObserver.send(value: viewModel)
        return viewModel
    }

    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<Never, NoError> {
        presentationViewModelObserver.send(value: viewModel)
        return SignalProducer.empty
    }
}
