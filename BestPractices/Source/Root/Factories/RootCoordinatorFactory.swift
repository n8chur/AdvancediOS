/// A factory for creating coordinators for root of the application.
///
/// This class also stores the view model / controller factories for the root.
///
/// This class' purpose is mainly to clean up dependency injection by taking that reponsibility from classes that should
/// not have knowledge of each of its view model's dependencies.
class RootCoordinatorFactory {

    let viewModel: RootViewModelFactory
    let viewController: RootViewControllerFactory

    init(viewModel: RootViewModelFactory, viewController: RootViewControllerFactory) {
        self.viewModel = viewModel
        self.viewController = viewController
    }

    func makeHomeCoordinator() -> HomeCoordinator {
        let viewModel = self.viewModel.makeHomeViewModelFactory()
        let viewController = self.viewController.makeHomeViewControllerFactory()
        let factory = HomeCoordinatorFactory(viewModel: viewModel, viewController: viewController)
        return HomeCoordinator(factory: factory)
    }

    func makeDetailCoordinator() -> DetailCoordinator {
        let viewModel = self.viewModel.makeDetailViewModelFactory()
        let viewController = self.viewController.makeDetailViewControllerFactory()
        let factory = DetailCoordinatorFactory(viewModel: viewModel, viewController: viewController)
        return DetailCoordinator(factory: factory)
    }

    func makeSettingsCoordinator() -> SettingsCoordinator {
        let viewModel = self.viewModel.makeSettingsViewModelFactory()
        let viewController = self.viewController.makeSettingsViewControllerFactory()
        let factory = SettingsCoordinatorFactory(viewModel: viewModel, viewController: viewController)
        return SettingsCoordinator(factory: factory)
    }

}
