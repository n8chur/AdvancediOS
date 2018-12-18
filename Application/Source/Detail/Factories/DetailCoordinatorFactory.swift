/// A factory for creating coordinators for detail flow.
///
/// This class also stores the view model / controller factories for the detail flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that responsibility from classes that should
/// not have knowledge of each of its view model's dependencies.
class DetailCoordinatorFactory {

    let navigationModel: DetailNavigationModelFactory
    let viewController: DetailViewControllerFactory

    init(navigationModel: DetailNavigationModelFactory, viewController: DetailViewControllerFactory) {
        self.navigationModel = navigationModel
        self.viewController = viewController
    }

}
