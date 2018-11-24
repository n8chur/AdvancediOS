import ReactiveSwift
import Result
import Core

protocol DetailPresentingViewModel: class, ViewModel {
    var detailPresenter: DetailPresenter? { get set }
    var presentDetail: Action<(), Never, NoError> { get }
}

protocol DetailPresenter: class {
    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<Never, NoError>
}
