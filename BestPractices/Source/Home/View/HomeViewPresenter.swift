import ReactiveSwift
import Result
import Core

protocol HomePresentingViewModel: class, ViewModel {
    var homePresenter: HomePresenter? { get set }
    var presentHome: Action<(), Never, NoError> { get }
}

extension HomePresentingViewModel {

    /// Makes an action that is suitable to be set as the presentHome action.
    ///
    /// - Parameter setupViewModel: This closure will be called with the presenting view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presenting view model if necessary.
    func makePresentHome(setupViewModel: ((HomeViewModel) -> Void)? = nil) -> Action<(), Never, NoError> {
        return Action<(), Never, NoError> { [weak self] _ in
            return SignalProducer<Never, NoError> { (observer, lifetime) in
                guard let presenter = self?.homePresenter else {
                    fatalError()
                }

                let viewModel = presenter.makeHomeViewModel()

                setupViewModel?(viewModel)

                presenter.homePresentation(of: viewModel)
                    .take(during: lifetime)
                    .start(observer)
            }
        }
    }

}

protocol HomePresenter: DetailPresenter {
    func makeHomeViewModel() -> HomeViewModel
    func homePresentationContext(of viewModel: HomeViewModel) -> DismissablePresentationContext
}

fileprivate extension HomePresenter {

    func homePresentation(of viewModel: HomeViewModel) -> SignalProducer<Never, NoError> {
        let context = SignalProducer<DismissablePresentationContext, NoError> { [weak self] () -> DismissablePresentationContext in
            guard let self = self else { fatalError() }

            viewModel.detailPresenter = self

            return self.homePresentationContext(of: viewModel)
        }

        return context.flatMap(.latest) { context in
            return context.presentation.present.apply(context.presentAnimated)
                .flatMapError { _ in return SignalProducer<Never, NoError>.empty }
                .untilDisposal(retain: context)
        }
    }

}
