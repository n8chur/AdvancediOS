import RxSwift
import Action
import Presentations

protocol DetailPresentingViewModel: class, PresentingViewModel {
    var detailPresenter: DetailPresenter? { get set }
    var presentDetail: Action<Bool, DetailViewModel> { get }
}

extension DetailPresentingViewModel {

    /// Makes an action that is suitable to be set as the presentDetail action.
    ///
    /// This action should be executed with a Bool indicating whether the presentation should be animated.
    ///
    /// - Parameter factory: A factory to be used to generate the presented view model.
    /// - Parameter setupViewModel: This closure will be called with the presented view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presented view model if necessary.
    func makePresentDetail(
        withFactory factory: DetailViewModelFactoryProtocol,
        setupViewModel: ((DetailViewModel) -> Void)? = nil
    ) -> Action<Bool, DetailViewModel> {
        return makePresentAction { [weak self] animated -> DismissablePresentationContext<DetailViewModel>? in
            guard
                let self = self,
                let presenter = self.detailPresenter else {
                    return nil
            }

            let viewModel = factory.makeDetailViewModel()

            viewModel.selectionPresenter = presenter
            viewModel.foodTablePresenter = presenter

            setupViewModel?(viewModel)

            let presentation = presenter.detailPresentation(of: viewModel)

            return DismissablePresentationContext(presentation: presentation, viewModel: viewModel, presentAnimated: animated)
        }
    }

}

protocol DetailPresenter: SelectionPresenter, FoodTablePresenter {
    func detailPresentation(of viewModel: DetailViewModel) -> DismissablePresentation
}
