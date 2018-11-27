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

protocol DetailPresenter: SelectionPresenter {
    func makeDetailViewModel() -> DetailViewModel
    func detailPresentationContext(of viewModel: DetailViewModel) -> DismissablePresentationContext
}

fileprivate extension DetailPresenter {

    func detailPresentation(of viewModel: DetailViewModel) -> SignalProducer<Never, NoError> {
        let context = SignalProducer<DismissablePresentationContext, NoError> { [weak self] () -> DismissablePresentationContext in
            guard let self = self else { fatalError() }

            viewModel.selectionPresenter = self

            return self.detailPresentationContext(of: viewModel)
        }

        return context.flatMap(.latest) { context in
            return context.presentation.present.apply(context.presentAnimated)
                .flatMapError { _ in return SignalProducer<Never, NoError>.empty }
                .untilDisposal(retain: context)
        }
    }

}
