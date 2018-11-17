import UIKit
import Core

class DetailCoordinator: Coordinator {

    typealias ViewModel = DetailViewModel

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(_ viewModel: DetailViewModel, completion: (() -> Void)? = nil) {
        let viewController = DetailViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true, completion: completion)
    }

}
