import ReactiveSwift
import Core

class RootNavigationModel: ViewModel, RootViewPresentingViewModel {

    let isActive = MutableProperty<Bool>(false)

    weak var rootViewPresenter: RootViewPresenter?

    private(set) lazy var presentRootView = Action<(), (), RootViewPresentError> { [weak self] _ in
        guard let presenter = self?.rootViewPresenter else {
            fatalError()
        }

        let viewModel = RootViewModel()

        return presenter.rootViewPresentation(of: viewModel)
            .mapError { _ in return .unknown }
    }

}
