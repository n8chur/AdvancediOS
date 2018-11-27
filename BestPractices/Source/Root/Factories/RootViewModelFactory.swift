import Core

/// A factory for creating view models for root of the application.
///
/// This class' purpose is mainly to clean up dependency injection by taking that reponsibility from classes that should
/// not have knowledge of each of its view model's dependencies.
class RootViewModelFactory {

    func makeHomeViewModelFactory() -> HomeViewModelFactory {
        return HomeViewModelFactory()
    }

    func makeRootTabBarViewModel() -> RootTabBarViewModel {
        return RootTabBarViewModel()
    }

}