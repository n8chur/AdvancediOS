import Core

/// A factory for creating view controllers for the application.
///
/// This class' purpose is mainly to clean up dependency injection by taking that reponsibility from classes that should
/// not have knowledge of each of its view controller's dependencies.
class ApplicationViewControllerFactory {

    func makeDetailViewController(viewModel: DetailViewModel) -> DetailViewController {
        return DetailViewController(viewModel: viewModel)
    }

    func makeSelectionViewController(viewModel: SelectionViewModel) -> SelectionViewController {
        return SelectionViewController(viewModel: viewModel)
    }

}
