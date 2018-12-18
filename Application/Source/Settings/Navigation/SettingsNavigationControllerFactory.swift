import Core

protocol SettingsNavigationControllerFactoryProtocol: TabBarChildNavigationControllerFactoryProtocol, SettingsViewControllerFactoryProtocol { }

extension SettingsNavigationControllerFactoryProtocol {

    func makeSettingsNavigationController(navigationModel: SettingsNavigationModel) -> TabBarChildNavigationController {
        return makeTabBarChildNavigationController(viewModel: navigationModel)
    }

}

/// A factory for creating view controllers for the settings flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that responsibility from classes that should
/// not have knowledge of each of its view controller's dependencies.
class SettingsNavigationControllerFactory: SettingsNavigationControllerFactoryProtocol {

    let themeProvider: ThemeProvider

    init(themeProvider: ThemeProvider) {
        self.themeProvider = themeProvider
    }

}
