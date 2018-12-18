import ReactiveSwift
import Presentations
import Core

class RootTabBarViewModel: ViewModel {

    let isActive = MutableProperty<Bool>(false)

    init() { }

}

protocol RootTabBarModelFactoryProtocol: HomeNavigationModelFactoryProtocol, DetailNavigationModelFactoryProtocol, SettingsNavigationModelFactoryProtocol { }

extension RootTabBarModelFactoryProtocol {

    func makeRootTabBarViewModel() -> RootTabBarViewModel {
        return RootTabBarViewModel()
    }

}

/// A factory for creating view models for root of the application.
///
/// This class' purpose is mainly to clean up dependency injection by taking that responsibility from classes that should
/// not have knowledge of each of its view model's dependencies.
class RootTabBarModelFactory: RootTabBarModelFactoryProtocol {

    let themeProvider: ThemeProvider

    init(themeProvider: ThemeProvider) {
        self.themeProvider = themeProvider
    }

}
