import UIKit
import Core
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

    let navigationController: HomeNavigationController

    private let factory: HomeCoordinatorFactory

    init(factory: HomeCoordinatorFactory) {
        self.factory = factory

        let navigationModel = factory.viewModel.makeHomeNavigationModel()
        let homeViewModel = factory.viewModel.makeHomeViewModel()

        navigationController = factory.viewController.makeHomeNavigationController(navigationModel: navigationModel, homeViewModel: homeViewModel)

        homeViewModel.detailPresenter = self
    }

}

extension HomeCoordinator: DetailPresenter {

    func makeDetailViewModel() -> DetailViewModel {
        return factory.viewModel.makeDetailViewModel()
    }

    func detailPresentationContext(of viewModel: DetailViewModel) -> DismissablePresentationContext {
        let viewController = factory.viewController.makeDetailViewController(viewModel: viewModel)
        let presentation = navigationController.makePushPresentation(of: viewController)
        return DismissablePresentationContext(presentation: presentation)
    }

}

extension HomeCoordinator: SelectionPresenter {

    func makeSelectionViewModel() -> SelectionViewModel {
        return factory.viewModel.makeSelectionViewModel()
    }

    func selectionPresentationContext(of viewModel: SelectionViewModel) -> DismissablePresentationContext {
        let viewController = factory.viewController.makeSelectionViewController(viewModel: viewModel)
        return self.navigationController.makeCancellablePresentationContext(of: viewController, viewModel: viewModel)
    }

}