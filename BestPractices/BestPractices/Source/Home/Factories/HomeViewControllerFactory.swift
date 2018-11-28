import Core

/// A factory for creating view controllers for the home flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that reponsibility from classes that should
/// not have knowledge of each of its view controller's dependencies.
class HomeViewControllerFactory {

    func makeHomeNavigationController(navigationModel: HomeNavigationModel, homeViewModel: HomeViewModel) -> HomeNavigationController {
        let homeViewController = makeHomeViewController(viewModel: homeViewModel)
        return HomeNavigationController(navigationModel: navigationModel, homeViewController: homeViewController)
    }

    func makeHomeViewController(viewModel: HomeViewModel) -> HomeViewController {
        return HomeViewController(viewModel: viewModel)
    }

    func makeDetailViewController(viewModel: DetailViewModel) -> DetailViewController {
        return DetailViewController(viewModel: viewModel)
    }

    func makeSelectionViewController(viewModel: SelectionViewModel) -> SelectionViewController {
        return SelectionViewController(viewModel: viewModel)
    }

}
