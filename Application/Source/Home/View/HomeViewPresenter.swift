import RxSwift
import Action
import Presentations

protocol HomePresentingViewModel: class, PresentingViewModel {
    var homePresenter: HomePresenter? { get set }
    var presentHome: Action<Bool, HomeViewModel> { get }
}

extension HomePresentingViewModel {

    /// Makes an action that is suitable to be set as the presentHome action.
    ///
    /// This action should be executed with a Bool indicating whether the presentation should be animated.
    ///
    /// - Parameter factory: A factory to be used to generate the presented view model.
    /// - Parameter setupViewModel: This closure will be called with the presented view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presented view model if necessary.
    func makePresentHome(
        withFactory factory: HomeViewModelFactoryProtocol,
        setupViewModel: ((HomeViewModel) -> Void)? = nil
    ) -> Action<Bool, HomeViewModel> {
        return makePresentAction { [weak self] animated -> DismissablePresentationContext<HomeViewModel>? in
            guard
                let self = self,
                let presenter = self.homePresenter else {
                    return nil
            }

            let viewModel = factory.makeHomeViewModel()

            viewModel.detailPresenter = presenter

            setupViewModel?(viewModel)

            let presentation = presenter.homePresentation(of: viewModel)

            return DismissablePresentationContext(presentation: presentation, viewModel: viewModel, presentAnimated: animated)
        }
    }

}

protocol HomePresenter: DetailPresenter {
    func homePresentation(of viewModel: HomeViewModel) -> DismissablePresentation
}
