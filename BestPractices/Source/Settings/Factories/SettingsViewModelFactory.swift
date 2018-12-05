/// A factory for creating view models for settings flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that reponsibility from classes that should
/// not have knowledge of each of its view model's dependencies.
class SettingsViewModelFactory: SettingsNavigationModelFactory {

    let themeProvider: ThemeProvider

    init(themeProvider: ThemeProvider) {
        self.themeProvider = themeProvider
    }

}
