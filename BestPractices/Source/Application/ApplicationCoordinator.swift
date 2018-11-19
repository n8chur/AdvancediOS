import UIKit
import Core
import ReactiveSwift
import Result

class ApplicationCoordinator: Coordinator {

    typealias ViewModel = ApplicationViewModel

    let rootNavigationCoordinator: RootNavigationCoordinator

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        rootNavigationCoordinator = RootNavigationCoordinator(window: window)
    }

    func start(viewModel: ApplicationViewModel, completion: (() -> Void)? = nil) {
        viewModel.rootNavigationPresenter = self
        viewModel.presentRootNavigation.apply().startWithCompleted { completion?() }
    }

}

extension ApplicationCoordinator: RootNavigationPresenter {
    func presentRootNavigation(_ viewModel: RootNavigationModel) -> SignalProducer<RootNavigationModel, NoError> {
        return rootNavigationCoordinator.makeStart(viewModel)
    }
}
