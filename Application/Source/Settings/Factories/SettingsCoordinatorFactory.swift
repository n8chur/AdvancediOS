/// A factory for creating coordinators for settings flow.
///
/// This class also stores the view model / controller factories for the settings flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that responsibility from classes that should
/// not have knowledge of each of its view model's dependencies.
class SettingsCoordinatorFactory {

    let navigationModel: SettingsNavigationModelFactory
    let viewController: SettingsViewControllerFactory

    init(navigationModel: SettingsNavigationModelFactory, viewController: SettingsViewControllerFactory) {
        self.navigationModel = navigationModel
        self.viewController = viewController
    }

}
