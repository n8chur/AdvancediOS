import ReactiveSwift
import Core

class RootNavigationModel: ViewModel, RootViewPresentingViewModel {

    let isActive = MutableProperty<Bool>(false)

    weak var rootViewPresenter: RootViewPresenter?

    private(set) lazy var presentRootView = Action<(), (), RootViewPresentError> { [weak self] _ in
        let viewModel = SignalProducer<RootViewModel, RootViewPresentationError> { RootViewModel() }

        return viewModel
            .flatMap(.merge) { viewModel -> SignalProducer<(), RootViewPresentationError> in
                guard let presenter = self?.rootViewPresenter else {
                    fatalError()
                }

                return presenter.rootViewPresentation(of: viewModel)
            }
            .mapError { _ in return .unknown }

    }

}
