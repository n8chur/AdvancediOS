import Core

/// A factory for creating view controllers for the detail flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that responsibility from classes that should
/// not have knowledge of each of its view controller's dependencies.
class DetailViewControllerFactory: DetailNavigationControllerFactory {

    let themeProvider: ThemeProvider

    init(themeProvider: ThemeProvider) {
        self.themeProvider = themeProvider
    }

}
