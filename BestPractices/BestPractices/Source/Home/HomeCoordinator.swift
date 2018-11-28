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

    let navigationController: TabBarChildNavigationController

    private let factory: HomeCoordinatorFactory

    init(factory: HomeCoordinatorFactory) {
        self.factory = factory

        let navigationModel = factory.viewModel.makeHomeNavigationModel()
        navigationController = factory.viewController.makeHomeNavigationController(navigationModel: navigationModel)

        navigationModel.homePresenter = self
        navigationModel.presentHome.apply().start()
    }

}

extension HomeCoordinator: HomePresenter {

    func makeHomeViewModel() -> HomeViewModel {
        return factory.viewModel.makeHomeViewModel()
    }

    func homePresentationContext(of viewModel: HomeViewModel) -> DismissablePresentationContext {
        let viewController = factory.viewController.makeHomeViewController(viewModel: viewModel)
        let presentation = navigationController.makePushPresentation(of: viewController)

        // Do not present/dismiss animated since this is the root view controller.
        return DismissablePresentationContext(presentation: presentation, presentAnimated: false, dismissAnimated: false)
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
