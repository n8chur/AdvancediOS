import ReactiveSwift
import Result
import Presentations

protocol HomePresentingViewModel: class, PresentingViewModel {
    var homePresenter: HomePresenter? { get set }
    var presentHome: Action<Bool, HomeViewModel, NoError> { get }
}

extension HomePresentingViewModel {

    /// Makes an action that is suitable to be set as the presentHome action.
    ///
    /// This action should be executed with a Bool indicating whether the presentation should be animated.
    ///
    /// - Parameter setupViewModel: This closure will be called with the presenting view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presenting view model if necessary.
    func makePresentHome(setupViewModel: ((HomeViewModel) -> Void)? = nil) -> Action<Bool, HomeViewModel, NoError> {
        return makePresentAction { [weak self] animated -> DismissablePresentationContext<HomeViewModel>? in
            guard
                let self = self,
                let presenter = self.homePresenter else {
                    return nil
            }

            let viewModel = presenter.makeHomeViewModel()

            viewModel.detailPresenter = presenter

            setupViewModel?(viewModel)

            let presentation = presenter.homePresentation(of: viewModel)

            return DismissablePresentationContext(presentation: presentation, viewModel: viewModel, presentAnimated: animated)
        }
    }

}

protocol HomePresenter: DetailPresenter {
    func makeHomeViewModel() -> HomeViewModel
    func homePresentation(of viewModel: HomeViewModel) -> DismissablePresentation
}
