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

    private let factory: HomeCoordinatorFactory

    init(factory: HomeCoordinatorFactory) {
        self.factory = factory

        let navigationModel = factory.viewModel.makeHomeNavigationModel()
        navigationController = factory.viewController.makeHomeNavigationController(navigationModel: navigationModel)

        navigationModel.homePresenter = self
        navigationModel.presentHome.apply(false).start()
    }

}

extension HomeCoordinator: HomePresenter {

    func makeHomeViewModel() -> HomeViewModel {
        return factory.viewModel.makeHomeViewModel()
    }

    func homePresentation(of viewModel: HomeViewModel) -> DismissablePresentation {
        let viewController = factory.viewController.makeHomeViewController(viewModel: viewModel)
        return navigationController.makePushPresentation(of: viewController)
    }

}

extension HomeCoordinator: DetailPresenter {

    func makeDetailViewModel() -> DetailViewModel {
        return factory.viewModel.makeDetailViewModel()
    }

    func detailPresentation(of viewModel: DetailViewModel) -> DismissablePresentation {
        let viewController = factory.viewController.makeDetailViewController(viewModel: viewModel)
        return navigationController.makePushPresentation(of: viewController)
    }

}

extension HomeCoordinator: SelectionPresenter {

    func makeSelectionViewModel(withDefaultValue defaultValue: String?) -> SelectionViewModel {
        return factory.viewModel.makeSelectionViewModel(withDefaultValue: defaultValue)
    }

    func selectionPresentation(of viewModel: SelectionViewModel) -> DismissablePresentation {
        let viewController = factory.viewController.makeSelectionViewController(viewModel: viewModel)
        let navigationController = factory.viewController.makeSingleViewNavigationController(rootViewController: viewController)
        let presentation = self.navigationController.makeModalPresentation(of: navigationController)
        presentation.addCancelBarButtonItem(to: viewController, animated: true)
        return presentation
    }

}
