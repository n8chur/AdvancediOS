protocol SettingsNavigationControllerFactory: TabBarChildNavigationControllerFactoryProtocol, SettingsViewControllerFactoryProtocol { }

extension SettingsNavigationControllerFactory {

    func makeSettingsNavigationController(navigationModel: SettingsNavigationModel) -> TabBarChildNavigationController {
        return makeTabBarChildNavigationController(viewModel: navigationModel)
    }

}
