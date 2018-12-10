import Core

/// A factory for creating view models for root of the application.
///
/// This class' purpose is mainly to clean up dependency injection by taking that responsibility from classes that should
/// not have knowledge of each of its view model's dependencies.
class RootViewModelFactory {

    let themeProvider: ThemeProvider

    init(themeProvider: ThemeProvider) {
        self.themeProvider = themeProvider
    }

    func makeHomeViewModelFactory() -> HomeViewModelFactory {
        return HomeViewModelFactory()
    }

    func makeDetailViewModelFactory() -> DetailViewModelFactory {
        return DetailViewModelFactory()
    }

    func makeSettingsViewModelFactory() -> SettingsViewModelFactory {
        return SettingsViewModelFactory(themeProvider: themeProvider)
    }

    func makeRootTabBarViewModel() -> RootTabBarViewModel {
        return RootTabBarViewModel()
    }

}
