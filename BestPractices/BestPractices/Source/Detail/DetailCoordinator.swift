import UIKit
import Core
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
        navigationModel.presentDetail.apply().start()
    }

}

extension DetailCoordinator: DetailPresenter {

    func makeDetailViewModel() -> DetailViewModel {
        return factory.viewModel.makeDetailViewModel()
    }

    func detailPresentationContext(of viewModel: DetailViewModel) -> DismissablePresentationContext {
        let viewController = factory.viewController.makeDetailViewController(viewModel: viewModel)
        let presentation = navigationController.makePushPresentation(of: viewController)

        // Do not present/dismiss animated since this is the root view controller.
        return DismissablePresentationContext(presentation: presentation, presentAnimated: false, dismissAnimated: false)
    }

}

extension DetailCoordinator: SelectionPresenter {

    func makeSelectionViewModel() -> SelectionViewModel {
        return factory.viewModel.makeSelectionViewModel()
    }

    func selectionPresentationContext(of viewModel: SelectionViewModel) -> DismissablePresentationContext {
        let viewController = factory.viewController.makeSelectionViewController(viewModel: viewModel)
        return self.navigationController.makeCancellablePresentationContext(of: viewController, viewModel: viewModel)
    }

}
