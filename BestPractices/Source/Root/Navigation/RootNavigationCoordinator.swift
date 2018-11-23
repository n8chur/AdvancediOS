import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift
import Result

class RootNavigationCoordinator: Coordinator {

    typealias ViewModel = RootNavigationModel
    typealias StartError = ActionError<RootViewPresentError>

    private(set) lazy var start = Action<ViewModel, (), StartError> { [weak self] navigationModel in
        let setup = SignalProducer<RootNavigationController, NoError> { () -> RootNavigationController in
            guard
                let strongSelf = self,
                let window = strongSelf.window else {
                    fatalError()
            }

            let navigationController = RootNavigationController(navigationModel: navigationModel)
            strongSelf.navigationController = navigationController

            navigationModel.rootViewPresenter = self

            window.rootViewController = navigationController
            window.makeKeyAndVisible()

            return navigationController
        }

        return setup
            .flatMap(.merge) { navigationController -> SignalProducer<RootNavigationController, ActionError<RootViewPresentError>> in
                let didMoveToNilWindow = navigationController.reactive.didMoveToNilWindow.ignoreValues()

                return navigationController.navigationModel.presentRootView.apply()
                    .then(SignalProducer<RootNavigationController, ActionError<RootViewPresentError>>.never)
                    .take(until: didMoveToNilWindow)
            }
            .ignoreValues()
    }

    private weak var window: UIWindow?
    private var rootViewCoordinator: RootViewCoordinator?
    private var navigationController: RootNavigationController?

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
