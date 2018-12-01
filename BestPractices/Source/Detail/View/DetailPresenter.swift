import ReactiveSwift
import Result
import Presentations

protocol DetailPresentingViewModel: class, PresentingViewModel {
    var detailPresenter: DetailPresenter? { get set }
    var presentDetail: Action<(), Never, NoError> { get }
}

extension DetailPresentingViewModel {

    /// Makes an action that is suitable to be set as the presentDetail action.
    ///
    /// - Parameter setupViewModel: This closure will be called with the presenting view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presenting view model if necessary.
    func makePresentDetail(setupViewModel: ((DetailViewModel) -> Void)? = nil) -> Action<(), Never, NoError> {
        return makePresent(
            getPresenter: { [weak self] in
                return self?.detailPresenter
            },
            getViewModel: { (presenter) in
                return presenter.makeDetailViewModel()
            },
            setupViewModel: setupViewModel,
            getPresentationProducer: { (presenter, viewModel) in
                return presenter.detailPresentation(of: viewModel)
            })
    }

}

protocol DetailPresenter: SelectionPresenter {
    func makeDetailViewModel() -> DetailViewModel
    func detailPresentationContext(of viewModel: DetailViewModel) -> DismissablePresentationContext
}

fileprivate extension DetailPresenter {

    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<Never, NoError> {
        return makePresentation(
            of: viewModel,
            setupPresenters: { [weak self] viewModel in
                viewModel.selectionPresenter = self
            },
            getContext: { [weak self] viewModel in
                return self?.detailPresentationContext(of: viewModel)
            })
    }

}
