import ReactiveSwift
import Result
import Core

enum DetailPresentError: Error {
    case unknown
}

protocol DetailPresentingViewModel: class {
    var detailPresenter: DetailPresenter? { get set }
    var presentDetail: Action<(), (), DetailPresentError> { get }
}

enum DetailPresentationError: Error {
    case unknown
}

protocol DetailPresenter: class {
    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<(), DetailPresentationError>
}
