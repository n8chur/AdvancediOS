import Presentations
import Core
import UIKit

class RootTabBarController: TabBarController<RootTabBarViewModel> {

    init(viewModel: RootTabBarViewModel, tabBarControllerFactory: RootTabBarControllerFactoryProtocol, themeProvider: ThemeProvider) {
        let home = HomeNavigationController(navigationModel: viewModel.home, navigationControllerFactory: tabBarControllerFactory, themeProvider: themeProvider)
        let detail = DetailNavigationController(navigationModel: viewModel.detail, navigationControllerFactory: tabBarControllerFactory, themeProvider: themeProvider)
        let settings = SettingsNavigationController(navigationModel: viewModel.settings, navigationControllerFactory: tabBarControllerFactory, themeProvider: themeProvider)

        let viewControllers = [
            home,
            detail,
            settings,
        ]
        super.init(viewModel: viewModel, themeProvider: themeProvider, viewControllers: viewControllers)
    }

}

protocol RootTabBarControllerFactoryProtocol: HomeNavigationControllerFactoryProtocol, DetailNavigationControllerFactoryProtocol, SettingsNavigationControllerFactoryProtocol { }

class RootTabBarControllerFactory: RootTabBarControllerFactoryProtocol {

    let themeProvider: ThemeProvider

    init(themeProvider: ThemeProvider) {
        self.themeProvider = themeProvider
    }

}
