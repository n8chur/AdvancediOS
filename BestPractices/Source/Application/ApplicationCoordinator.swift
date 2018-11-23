import UIKit
import Core
import ReactiveSwift
import Result

/// Coordinates presenting the RootNavigationCoordinator in the application.
class ApplicationCoordinator: Coordinator {

    typealias ViewModel = ApplicationViewModel
    typealias StartError = ActionError<RootNavigationPresentError>

    private weak var window: UIWindow?

    private(set) lazy var start = Action<ViewModel, (), StartError> { [weak self] viewModel in
        let setup = SignalProducer<ViewModel, StartError> { () -> ViewModel in
            guard let strongSelf = self else {
                fatalError()
            }

            viewModel.rootNavigationPresenter = strongSelf

            // This should be hooked up to the UIApplication's state, but the value is currently unused so it has been
            // omitted for simplicity.
            viewModel.isActive.value = true

            return viewModel
        }

        return setup
            .flatMap(.merge) { return $0.presentRootNavigation.apply() }
            .ignoreValues()
    }

    init(window: UIWindow) {
        self.window = window
    }

}

extension ApplicationCoordinator: RootNavigationPresenter {

    func rootNavigationPresentation(of navigationModel: RootNavigationModel) -> SignalProducer<(), RootNavigationPresentationError> {
        guard let window = self.window else {
            fatalError()
        }

        return RootNavigationCoordinator.rootNavigationPresentation(in: window, of: navigationModel)
    }

}
