protocol SettingsNavigationControllerFactory: SettingsViewControllerFactoryProtocol { }

extension SettingsNavigationControllerFactory {

    func makeSettingsNavigationController(navigationModel: SettingsNavigationModel) -> TabBarChildNavigationController {
        return TabBarChildNavigationController(navigationModel: navigationModel)
    }

}
