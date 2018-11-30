/// A factory for creating coordinators for home flow.
///
/// This class also stores the view model / controller factories for the home flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that reponsibility from classes that should
/// not have knowledge of each of its view model's dependencies.
class HomeCoordinatorFactory {

    let viewModel: HomeViewModelFactory
    let viewController: HomeViewControllerFactory

    init(viewModel: HomeViewModelFactory, viewController: HomeViewControllerFactory) {
        self.viewModel = viewModel
        self.viewController = viewController
    }

}
