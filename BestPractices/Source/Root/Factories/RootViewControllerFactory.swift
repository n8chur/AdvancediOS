import Core

/// A factory for creating view controllers for the root of the application.
///
/// This class' purpose is mainly to clean up dependency injection by taking that reponsibility from classes that should
/// not have knowledge of each of its view controller's dependencies.
class RootViewControllerFactory {

    func makeHomeViewControllerFactory() -> HomeViewControllerFactory {
        return HomeViewControllerFactory()
    }

    func makeRootTabBarController(viewModel: RootTabBarViewModel, homeNavigationController: HomeNavigationController) -> RootTabBarController {
        return RootTabBarController(viewModel: viewModel, homeNavigationController: homeNavigationController)
    }

}
