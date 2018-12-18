import Presentations
import Core
import UIKit

protocol RootTabBarControllerFactoryProtocol: HomeNavigationControllerFactoryProtocol, DetailNavigationControllerFactoryProtocol, SettingsNavigationControllerFactoryProtocol { }

extension RootTabBarControllerFactoryProtocol {

    func makeRootTabBarController(
        withViewModel viewModel: RootTabBarViewModel,
        homeNavigationController: TabBarChildNavigationController,
        detailNavigationController: TabBarChildNavigationController,
        settingsNavigationController: TabBarChildNavigationController
    ) -> TabBarController {
        let viewControllers = [
            homeNavigationController,
            detailNavigationController,
            settingsNavigationController,
        ]
        return TabBarController(viewModel: viewModel, themeProvider: themeProvider, viewControllers: viewControllers)
    }

}

/// A factory for creating view controllers for the root of the application.
///
/// This class' purpose is mainly to clean up dependency injection by taking that responsibility from classes that should
/// not have knowledge of each of its view controller's dependencies.
class RootTabBarControllerFactory: RootTabBarControllerFactoryProtocol {

    let themeProvider: ThemeProvider

    init(themeProvider: ThemeProvider) {
        self.themeProvider = themeProvider
    }

}
