/// A factory for creating coordinators for home flow.
///
/// This class also stores the view model / controller factories for the home flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that responsibility from classes that should
/// not have knowledge of each of its view model's dependencies.
class HomeCoordinatorFactory {

    let navigationModel: HomeNavigationModelFactory
    let viewController: HomeViewControllerFactory

    init(navigationModel: HomeNavigationModelFactory, viewController: HomeViewControllerFactory) {
        self.navigationModel = navigationModel
        self.viewController = viewController
    }

}
