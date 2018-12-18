import UIKit
import Presentations
import ReactiveCocoa
import ReactiveSwift
import Result

/// The flow coordinator for the home flow.
///
/// This class is responsible for:
/// - Instantiating the home navigation controller
/// - Handling presentation of views controllers in the navigation controller
/// - Forwarding view model creation to the view model factory it was initialized with
/// - Forwarding view controller creation to the view controller factory it was initialized with
class HomeCoordinator {

    let navigationController: TabBarChildNavigationController

    init(navigationModelFactory: HomeNavigationModelFactoryProtocol, navigationControllerFactory: HomeNavigationControllerFactoryProtocol) {
        self.factory = navigationControllerFactory

        let navigationModel = navigationModelFactory.makeHomeNavigationModel()
        navigationController = navigationControllerFactory.makeHomeNavigationController(navigationModel: navigationModel)

        navigationModel.homePresenter = self
        navigationModel.presentHome.apply(false).start()
    }

    private let factory: HomeNavigationControllerFactoryProtocol

}

extension HomeCoordinator: HomePresenter {

    func homePresentation(of viewModel: HomeViewModel) -> DismissablePresentation {
        let viewController = factory.makeHomeViewController(viewModel: viewModel)
        return navigationController.makePushPresentation(of: viewController)
    }

}

extension HomeCoordinator: DetailPresenter {

    func detailPresentation(of viewModel: DetailViewModel) -> DismissablePresentation {
        let viewController = factory.makeDetailViewController(viewModel: viewModel)
        return navigationController.makePushPresentation(of: viewController)
    }

}

extension HomeCoordinator: SelectionPresenter {

    func selectionPresentation(of viewModel: SelectionViewModel) -> DismissablePresentation {
        let viewController = factory.makeSelectionViewController(viewModel: viewModel)
        let navigationController = factory.makeSingleViewNavigationController(rootViewController: viewController)
        let presentation = self.navigationController.makeModalPresentation(of: navigationController)
        presentation.addCancelBarButtonItem(to: viewController, animated: true)
        return presentation
    }

}
