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
        let setupNavigationController = SignalProducer<RootNavigationModel, NoError> { [weak self] () -> RootNavigationModel in
            guard let strongSelf = self else {
                fatalError()
            }

            let navigationController = RootNavigationController(navigationModel: navigationModel)
            strongSelf.navigationController = navigationController

            navigationModel.rootViewPresenter = self

            strongSelf.window.rootViewController = navigationController
            strongSelf.window.makeKeyAndVisible()

            return navigationModel
        }

        return setupNavigationController
            .flatMap(.merge) { $0.presentRootView.apply() }
            .ignoreValues()
    }

}

extension RootNavigationCoordinator: RootViewPresenter {

    func rootViewPresentation(of viewModel: RootViewModel) -> SignalProducer<(), RootViewPresentationError> {
        let makeCoordinator = SignalProducer<RootViewCoordinator, NoError> { [weak self] () -> RootViewCoordinator in
            guard let strongSelf = self,
                let navigationController = strongSelf.navigationController else {
                fatalError()
            }

            let coordinator = RootViewCoordinator(navigationController: navigationController)

            strongSelf.rootViewCoordinator = coordinator

            return coordinator
        }

        return makeCoordinator
            .flatMap(.merge) { $0.start.apply(viewModel) }
            .mapError { _ in return .unknown }
    }

}
