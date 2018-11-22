import ReactiveSwift
import Result
import Core

class ApplicationViewModel: ViewModel, RootNavigationPresentingViewModel {

    var isActive = MutableProperty(false)

    weak var rootNavigationPresenter: RootNavigationPresenter?

    private(set) lazy var presentRootNavigation = Action<(), (), RootNavigationPresentError> { [weak self] _ in
        guard let presenter = self?.rootNavigationPresenter else {
            fatalError()
        }

        let navigationModel = RootNavigationModel()

        return presenter.rootNavigationPresentation(of: navigationModel)
            .mapError { _ in return .unknown }
    }

}
