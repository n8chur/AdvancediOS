/// A factory for creating coordinators for settings flow.
///
/// This class also stores the view model / controller factories for the settings flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that reponsibility from classes that should
/// not have knowledge of each of its view model's dependencies.
class SettingsCoordinatorFactory {

    let viewModel: SettingsViewModelFactory
    let viewController: SettingsViewControllerFactory

    init(viewModel: SettingsViewModelFactory, viewController: SettingsViewControllerFactory) {
        self.viewModel = viewModel
        self.viewController = viewController
    }

}
