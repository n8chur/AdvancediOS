import UIKit
import Presentations
import ReactiveCocoa
import ReactiveSwift
import Result

/// The flow coordinator for the detail flow.
///
/// This class is responsible for:
/// - Instantiating the navigation controller
/// - Generating presentations of view controllers when requested by a view model
class DetailCoordinator {

    let navigationController: TabBarChildNavigationController

    init(navigationModelFactory: DetailNavigationModelFactoryProtocol, navigationControllerFactory: DetailNavigationControllerFactoryProtocol) {
        self.factory = navigationControllerFactory

        let navigationModel = navigationModelFactory.makeDetailNavigationModel()
        navigationController = factory.makeDetailNavigationController(navigationModel: navigationModel)

        navigationModel.detailPresenter = self
        navigationModel.presentDetail.apply(false).start()
    }

    private let factory: DetailNavigationControllerFactoryProtocol

}

extension DetailCoordinator: DetailPresenter {

    func detailPresentation(of viewModel: DetailViewModel) -> DismissablePresentation {
        let viewController = factory.makeDetailViewController(viewModel: viewModel)
        return navigationController.makePushPresentation(of: viewController)
    }

}

extension DetailCoordinator: SelectionPresenter {

    func selectionPresentation(of viewModel: SelectionViewModel) -> DismissablePresentation {
        let viewController = factory.makeSelectionViewController(viewModel: viewModel)
        let navigationController = factory.makeSingleViewNavigationController(rootViewController: viewController)
        let presentation = self.navigationController.makeModalPresentation(of: navigationController)
        presentation.addCancelBarButtonItem(to: viewController, animated: true)
        return presentation
    }

}
