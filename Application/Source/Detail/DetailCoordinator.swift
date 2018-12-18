import UIKit
import Presentations
import ReactiveCocoa
import ReactiveSwift
import Result

/// The flow coordinator for the detail flow.
///
/// This class is responsible for:
/// - Instantiating the detail navigation controller
/// - Handling presentation of views controllers in the navigation controller
/// - Forwarding view model creation to the view model factory it was initialized with
/// - Forwarding view controller creation to the view controller factory it was initialized with
class DetailCoordinator {

    let navigationController: TabBarChildNavigationController

    private let factory: DetailCoordinatorFactory

    init(factory: DetailCoordinatorFactory) {
        self.factory = factory

        let navigationModel = factory.viewModel.makeDetailNavigationModel()
        navigationController = factory.viewController.makeDetailNavigationController(navigationModel: navigationModel)

        navigationModel.detailPresenter = self
        navigationModel.presentDetail.apply(false).start()
    }

}

extension DetailCoordinator: DetailPresenter {

    func makeDetailViewModel() -> DetailViewModel {
        return factory.viewModel.makeDetailViewModel()
    }

    func detailPresentation(of viewModel: DetailViewModel) -> DismissablePresentation {
        let viewController = factory.viewController.makeDetailViewController(viewModel: viewModel)
        return navigationController.makePushPresentation(of: viewController)
    }

}

extension DetailCoordinator: SelectionPresenter {

    func makeSelectionViewModel() -> SelectionViewModel {
        return factory.viewModel.makeSelectionViewModel()
    }

    func selectionPresentation(of viewModel: SelectionViewModel) -> DismissablePresentation {
        let viewController = factory.viewController.makeSelectionViewController(viewModel: viewModel)
        let navigationController = factory.viewController.makeSingleViewNavigationController(rootViewController: viewController)
        let presentation = self.navigationController.makeModalPresentation(of: navigationController)
        presentation.addCancelBarButtonItem(to: viewController, animated: true)
        return presentation
    }

}
