import ReactiveSwift
import Result
import Core

class ApplicationViewModel: ViewModel, RootNavigationPresentingViewModel {

    var presenter: RootNavigationPresenter?

    // TODO: This should be connected to Application active state.
    var isActive = MutableProperty(true)

    weak var rootNavigationPresenter: RootNavigationPresenter?

    var presentRootNavigation: Action<(), RootNavigationModel, NoError> {
        return _presentRootNavigation
    }

    private lazy var _presentRootNavigation = Action<(), RootNavigationModel, NoError> { [weak self] _ in
        guard let presenter = self?.rootNavigationPresenter else {
            fatalError()
        }

        let navigationModel = RootNavigationModel()
        return presenter.presentRootNavigation(navigationModel)
    }

}
