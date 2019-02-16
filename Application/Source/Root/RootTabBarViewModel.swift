import RxSwift
import RxCocoa
import RxExtensions
import Presentations
import Core

class RootTabBarViewModel: ViewModel {

    let isActive = BehaviorRelay<Bool>(value: false)

    let home: HomeNavigationModel
    let detail: DetailNavigationModel
    let settings: SettingsNavigationModel

    init(factory: RootTabBarModelFactoryProtocol) {
        home = factory.makeHomeNavigationModel()
        detail = factory.makeDetailNavigationModel()
        settings = factory.makeSettingsNavigationModel()
    }

}

protocol RootTabBarModelFactoryProtocol: HomeNavigationModelFactoryProtocol, DetailNavigationModelFactoryProtocol, SettingsNavigationModelFactoryProtocol {
    func makeRootTabBarViewModel() -> RootTabBarViewModel
}

extension RootTabBarModelFactoryProtocol {

    func makeRootTabBarViewModel() -> RootTabBarViewModel {
        return RootTabBarViewModel(factory: self)
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
