import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift
import Result

class RootNavigationCoordinator: Coordinator {

    typealias ViewModel = RootNavigationModel
    typealias StartError = ActionError<RootViewPresentError>

    private let window: UIWindow

    private var rootViewCoordinator: RootViewCoordinator?
    private var navigationController: RootNavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    private(set) lazy var start = Action<ViewModel, (), StartError> { [weak self] navigationModel in
        let setup = SignalProducer<RootNavigationController, NoError> { [weak self] () -> RootNavigationController in
            guard let strongSelf = self else {
                fatalError()
            }

            let navigationController = RootNavigationController(navigationModel: navigationModel)
            strongSelf.navigationController = navigationController

            navigationModel.rootViewPresenter = self

            strongSelf.window.rootViewController = navigationController
            strongSelf.window.makeKeyAndVisible()

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

}

extension RootNavigationCoordinator: RootViewPresenter {

    func rootViewPresentation(of viewModel: RootViewModel) -> SignalProducer<(), RootViewPresentationError> {
        guard let navigationController = self.navigationController else {
            fatalError()
        }

        return RootViewCoordinator.rootViewPresentation(in: navigationController, of: viewModel)
    }

}
