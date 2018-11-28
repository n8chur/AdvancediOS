import ReactiveSwift
import Result
import Core

protocol HomePresentingViewModel: class, PresentingViewModel {
    var homePresenter: HomePresenter? { get set }
    var presentHome: Action<(), Never, NoError> { get }
}

extension HomePresentingViewModel {

    /// Makes an action that is suitable to be set as the presentHome action.
    ///
    /// - Parameter setupViewModel: This closure will be called with the presenting view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presenting view model if necessary.
    func makePresentHome(setupViewModel: ((HomeViewModel) -> Void)? = nil) -> Action<(), Never, NoError> {
        return makePresent(
            getPresenter: { [weak self] in
                return self?.homePresenter
            },
            getViewModel: { (presenter) in
                return presenter.makeHomeViewModel()
            },
            setupViewModel: setupViewModel,
            getPresentationProducer: { (presenter, viewModel) in
                return presenter.homePresentation(of: viewModel)
            })
    }

}

protocol HomePresenter: DetailPresenter {
    func makeHomeViewModel() -> HomeViewModel
    func homePresentationContext(of viewModel: HomeViewModel) -> DismissablePresentationContext
}

fileprivate extension HomePresenter {

    func homePresentation(of viewModel: HomeViewModel) -> SignalProducer<Never, NoError> {
        return makePresentation(
            of: viewModel,
            setupPresenters: { [weak self] viewModel in
                viewModel.detailPresenter = self
            },
            getContext: { [weak self] viewModel in
                return self?.homePresentationContext(of: viewModel)
        })
    }

}
