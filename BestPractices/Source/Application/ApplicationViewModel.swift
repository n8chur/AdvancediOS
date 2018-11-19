import ReactiveSwift
import Result
import Core

class ApplicationViewModel: ViewModel, RootNavigationPresentingViewModel {

    // TODO: This should be connected to Application active state.
    var isActive = MutableProperty(true)

    weak var presenter: RootNavigationPresenter?

    var presentRootNavigation: Action<(), RootNavigationModel, NoError> {
        return _presentRootNavigation
    }

    private lazy var _presentRootNavigation = Action<(), RootNavigationModel, NoError> { [weak self] _ in
        guard let presenter = self?.presenter else {
            fatalError()
        }

        let navigationModel = RootNavigationModel()
        return presenter.presentRootNavigation(navigationModel)
    }

}
