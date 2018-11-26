import ReactiveSwift
import Result
import Core

protocol DetailPresentingViewModel: class, ViewModel {
    var detailPresenter: DetailPresenter? { get set }
    var presentDetail: Action<(), Never, NoError> { get }
}

extension DetailPresentingViewModel {
    func makePresentDetail(setupViewModel: ((DetailViewModel) -> Void)? = nil) -> Action<(), Never, NoError> {
        return Action<(), Never, NoError> { [weak self] _ in
            return SignalProducer<Never, NoError> { (observer, lifetime) in
                guard let presenter = self?.detailPresenter else {
                    fatalError()
                }

                let viewModel = presenter.makeDetailViewModel()

                setupViewModel?(viewModel)

                presenter.detailPresentation(of: viewModel)
                    .take(during: lifetime)
                    .start(observer)
            }
        }
    }
}

protocol DetailPresenter: class {
    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<Never, NoError>

    func makeDetailViewModel() -> DetailViewModel
}
