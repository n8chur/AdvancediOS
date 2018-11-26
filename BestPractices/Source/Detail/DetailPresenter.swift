import ReactiveSwift
import Result
import Core

protocol DetailPresentingViewModel: class, ViewModel {
    var detailPresenter: DetailPresenter? { get set }
    var presentDetail: Action<(), Never, NoError> { get }
}

extension DetailPresentingViewModel {

    /// Makes an action that is suitable to be set as the presentDetail action.
    ///
    /// - Parameter setupViewModel: This closure will be called with the presenting view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presenting view model if necessary.
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
    func makeDetailViewModel() -> DetailViewModel
    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<Never, NoError>
}
