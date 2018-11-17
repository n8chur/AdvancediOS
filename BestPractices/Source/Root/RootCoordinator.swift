import UIKit
import Core

class RootCoordinator: Coordinator {

    typealias ViewModel = RootNavigationModel

    let window: UIWindow

    var detailCoordinator: DetailCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start(_ viewModel: RootNavigationModel, completion: (() -> Void)? = nil) {
        let navigationController = RootNavigationController(navigationModel: viewModel)
        detailCoordinator = DetailCoordinator(navigationController: navigationController)

        viewModel.rootViewModel.selectDetails.values.observeValues { [weak self] detailViewModel in
            guard let detailCoordinator = self?.detailCoordinator else {
                print("Detail coordinator no longer allocated.")
                return
            }

            detailCoordinator.start(detailViewModel)
        }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}
