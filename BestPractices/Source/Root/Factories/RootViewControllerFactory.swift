import Presentations
import Core

/// A factory for creating view controllers for the root of the application.
///
/// This class' purpose is mainly to clean up dependency injection by taking that reponsibility from classes that should
/// not have knowledge of each of its view controller's dependencies.
class RootViewControllerFactory {

    let themeProvider: ThemeProvider

    init(themeProvider: ThemeProvider) {
        self.themeProvider = themeProvider
    }

    func makeHomeViewControllerFactory() -> HomeViewControllerFactory {
        return HomeViewControllerFactory(themeProvider: themeProvider)
    }

    func makeDetailViewControllerFactory() -> DetailViewControllerFactory {
        return DetailViewControllerFactory(themeProvider: themeProvider)
    }

    func makeSettingsViewControllerFactory() -> SettingsViewControllerFactory {
        return SettingsViewControllerFactory(themeProvider: themeProvider)
    }

    func makeRootTabBarController(viewModel: RootTabBarViewModel, homeNavigationController: TabBarChildNavigationController, detailNavigationController: TabBarChildNavigationController, settingsNavigationController: TabBarChildNavigationController) -> TabBarController {
        let viewControllers = [
            homeNavigationController,
            detailNavigationController,
            settingsNavigationController,
        ]
        return TabBarController(viewModel: viewModel, themeProvider: themeProvider, viewControllers: viewControllers)
    }

}
