import Core

protocol DetailNavigationControllerFactoryProtocol: TabBarChildNavigationControllerFactoryProtocol, DetailViewControllerFactoryProtocol, SingleViewNavigationControllerFactoryProtocol { }

extension DetailNavigationControllerFactoryProtocol {

    func makeDetailNavigationController(navigationModel: DetailNavigationModel) -> TabBarChildNavigationController {
        return makeTabBarChildNavigationController(viewModel: navigationModel)
    }

}

/// A factory for creating view controllers for the detail flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that responsibility from classes that should
/// not have knowledge of each of its view controller's dependencies.
class DetailNavigationControllerFactory: DetailNavigationControllerFactoryProtocol {

    let themeProvider: ThemeProvider

    init(themeProvider: ThemeProvider) {
        self.themeProvider = themeProvider
    }

}
