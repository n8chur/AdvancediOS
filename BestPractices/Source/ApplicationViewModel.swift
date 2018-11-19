import ReactiveSwift
import Result
import Core

class ApplicationViewModel: ViewModel, RootNavigationPresentingViewModel {

    // TODO: This should be connected to Application active state.
    var isActive = MutableProperty(true)

    weak var presenter: RootNavigationPresenter?

    lazy var presentRootNavigation = Action<(), RootNavigationModel, NoError> { [weak self] _ in
        guard let presenter = self?.presenter else {
            fatalError()
        }

        let navigationModel = RootNavigationModel()
        return presenter.presentRootNavigation(navigationModel)
    }

}
