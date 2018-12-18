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
        return makePresent(
            getPresenter: { [weak self] in
                return self?.homePresenter
            },
            getViewModel: { (presenter) in
                let viewModel = presenter.makeHomeViewModel()

                viewModel.detailPresenter = presenter

                setupViewModel?(viewModel)

                return viewModel
            },
            getPresentation: { (presenter, viewModel) in
                return presenter.homePresentation(of: viewModel)
            },
            getContext: { (presentation, _, animated) in
                return DismissablePresentationContext(presentation: presentation, presentAnimated: animated)
            })
    }

}

protocol HomePresenter: DetailPresenter {
    func makeHomeViewModel() -> HomeViewModel
    func homePresentation(of viewModel: HomeViewModel) -> DismissablePresentation
}
