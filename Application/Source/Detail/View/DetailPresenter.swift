import ReactiveSwift
import Result
import Presentations

protocol DetailPresentingViewModel: class, PresentingViewModel {
    var detailPresenter: DetailPresenter? { get set }
    var presentDetail: Action<Bool, DetailViewModel, NoError> { get }
}

extension DetailPresentingViewModel {

    /// Makes an action that is suitable to be set as the presentDetail action.
    ///
    /// This action should be executed with a Bool indicating whether the presentation should be animated.
    ///
    /// - Parameter setupViewModel: This closure will be called with the presenting view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presenting view model if necessary.
    func makePresentDetail(setupViewModel: ((DetailViewModel) -> Void)? = nil) -> Action<Bool, DetailViewModel, NoError> {
        return makePresent(
            getPresenter: { [weak self] in
                return self?.detailPresenter
            },
            getViewModel: { (presenter) in
                let viewModel = presenter.makeDetailViewModel()

                viewModel.selectionPresenter = presenter

                setupViewModel?(viewModel)

                return viewModel
            },
            getPresentation: { (presenter, viewModel) in
                return presenter.detailPresentation(of: viewModel)
            },
            getContext: { (presentation, _, animated) in
                return DismissablePresentationContext(presentation: presentation, presentAnimated: animated)
            })
    }

}

protocol DetailPresenter: SelectionPresenter {
    func makeDetailViewModel() -> DetailViewModel
    func detailPresentation(of viewModel: DetailViewModel) -> DismissablePresentation
}
