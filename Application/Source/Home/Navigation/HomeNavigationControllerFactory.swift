import Core

protocol HomeNavigationControllerFactoryProtocol: TabBarChildNavigationControllerFactoryProtocol, HomeViewControllerFactoryProtocol, SingleViewNavigationControllerFactoryProtocol { }

extension HomeNavigationControllerFactoryProtocol {

    func makeHomeNavigationController(navigationModel: HomeNavigationModel) -> TabBarChildNavigationController {
        return makeTabBarChildNavigationController(viewModel: navigationModel)
    }

}

/// A factory for creating view controllers for the home flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that responsibility from classes that should
/// not have knowledge of each of its view controller's dependencies.
class HomeNavigationControllerFactory: HomeNavigationControllerFactoryProtocol {

    let themeProvider: ThemeProvider

    init(themeProvider: ThemeProvider) {
        self.themeProvider = themeProvider
    }

}
