/// A factory for creating coordinators for root of the application.
///
/// This class also stores the view model / controller factories for the root.
///
/// This class' purpose is mainly to clean up dependency injection by taking that responsibility from classes that should
/// not have knowledge of each of its view model's dependencies.
class RootCoordinatorFactory {

    let viewModel: RootViewModelFactory
    let viewController: RootViewControllerFactory

    init(viewModel: RootViewModelFactory, viewController: RootViewControllerFactory) {
        self.viewModel = viewModel
        self.viewController = viewController
    }

    func makeHomeCoordinator() -> HomeCoordinator {
        let navigationModel = self.viewModel.makeHomeNavigationModelFactory()
        let viewController = self.viewController.makeHomeViewControllerFactory()
        let factory = HomeCoordinatorFactory(navigationModel: navigationModel, viewController: viewController)
        return HomeCoordinator(factory: factory)
    }

    func makeDetailCoordinator() -> DetailCoordinator {
        let navigationModel = self.viewModel.makeDetailNavigationModelFactory()
        let viewController = self.viewController.makeDetailViewControllerFactory()
        let factory = DetailCoordinatorFactory(navigationModel: navigationModel, viewController: viewController)
        return DetailCoordinator(factory: factory)
    }

    func makeSettingsCoordinator() -> SettingsCoordinator {
        let navigationModel = self.viewModel.makeSettingsNavigationModelFactory()
        let viewController = self.viewController.makeSettingsViewControllerFactory()
        let factory = SettingsCoordinatorFactory(navigationModel: navigationModel, viewController: viewController)
        return SettingsCoordinator(factory: factory)
    }

}
