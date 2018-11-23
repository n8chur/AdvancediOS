import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift
import Result

class RootNavigationCoordinator: Coordinator {

    typealias ViewModel = RootNavigationModel
    typealias StartError = ActionError<RootViewPresentError>

    private weak var window: UIWindow?
    /// This property will be nil until the start action has been applied.
    private weak var navigationController: RootNavigationController?

    private(set) lazy var start = Action<ViewModel, (), StartError> { [weak self] navigationModel in
        let setup = SignalProducer<RootNavigationController, NoError> { () -> RootNavigationController in
            guard
                let strongSelf = self,
                let window = strongSelf.window else {
                    fatalError()
            }

            let navigationController = RootNavigationController(navigationModel: navigationModel)
            // Keep a reference to the navigation controller so that it can be used in our presntation callbacks.
            strongSelf.navigationController = navigationController

            navigationModel.rootViewPresenter = strongSelf

            window.rootViewController = navigationController
            window.makeKeyAndVisible()

            return navigationController
        }

        return setup
            .flatMap(.merge) { navigationController -> SignalProducer<RootNavigationController, ActionError<RootViewPresentError>> in
                // Make the signal last until the navigation controller moves to a nil window.
                //
                // This ensures that the coordinator will be alive while the navigation controller is the active
                // window.rootViewController since it is retained for the duration of the start command (see
                // rootViewPresentation(in:of:)).
                //
                // This also ensures that the start action will be disabled while this navigation controller is
                // presented since the Action will still be executing.
                let didMoveToNilWindow = navigationController.reactive.didMoveToNilWindow.ignoreValues()
                return navigationController.navigationModel.presentRootView.apply()
                    .then(SignalProducer<RootNavigationController, ActionError<RootViewPresentError>>.never)
                    .take(until: didMoveToNilWindow)
            }
            .ignoreValues()
    }

    init(window: UIWindow) {
        self.window = window
    }

}

extension RootNavigationCoordinator: RootViewPresenter {

    func rootViewPresentation(of viewModel: RootViewModel) -> SignalProducer<(), RootViewPresentationError> {
        guard let navigationController = self.navigationController else {
            fatalError()
        }

        return RootViewCoordinator.rootViewPresentation(in: navigationController, of: viewModel)
    }

}


extension RootNavigationCoordinator {

    static func rootNavigationPresentation(in window: UIWindow, of navigationModel: RootNavigationModel) -> SignalProducer<(), RootNavigationPresentationError> {
        return SignalProducer<RootNavigationCoordinator, NoError> { RootNavigationCoordinator(window: window) }
            .flatMap(.merge) { coordinator in
                return coordinator.start.apply(navigationModel)
                    // This keeps the coordinator alive while the presentation is still active to ensure it can handle
                    // any presentation callbacks.
                    .untilDisposal(retain: coordinator)
            }
            .mapError { _ in return .unknown }
    }

}
