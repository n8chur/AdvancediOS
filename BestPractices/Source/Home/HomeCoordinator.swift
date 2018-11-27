import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift
import Result

/// The flow coordinator for the home flow.
///
/// This class is responsible for:
/// - Instantiating the root navigation controller
/// - Handling presentation of views controllers in the navigation controller
/// - Forwarding view model creation to the view model factory it was initialized with
/// - Forwarding view controller creation to the view controller factory it was initialized with
class HomeCoordinator {

    let viewModelFactory: HomeViewModelFactory
    let viewControllerFactory: HomeViewControllerFactory
    let navigationModel: HomeNavigationModel
    let navigationController: HomeNavigationController

    init(viewModelFactory: HomeViewModelFactory, viewControllerFactory: HomeViewControllerFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewControllerFactory = viewControllerFactory

        navigationModel = viewModelFactory.makeHomeNavigationModel()
        navigationController = viewControllerFactory.makeHomeNavigationController(navigationModel: navigationModel)

        navigationModel.homeViewModel.detailPresenter = self
    }

}

extension HomeCoordinator: DetailPresenter {

    func makeDetailViewModel() -> DetailViewModel {
        return viewModelFactory.makeDetailViewModel()
    }

    func detailPresentationContext(of viewModel: DetailViewModel) -> DismissablePresentationContext {
        let viewController = viewControllerFactory.makeDetailViewController(viewModel: viewModel)
        let presentation = navigationController.makePushPresentation(of: viewController)
        return DismissablePresentationContext(presentation: presentation)
    }

}

extension HomeCoordinator: SelectionPresenter {

    func makeSelectionViewModel() -> SelectionViewModel {
        return viewModelFactory.makeSelectionViewModel()
    }

    func selectionPresentationContext(of viewModel: SelectionViewModel) -> DismissablePresentationContext {
        let viewController = viewControllerFactory.makeSelectionViewController(viewModel: viewModel)

        return self.navigationController.makeCancellablePresentationContext(of: viewController, viewModel: viewModel)
    }

}
