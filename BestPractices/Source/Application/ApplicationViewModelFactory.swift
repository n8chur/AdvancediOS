import Core

/// A factory for creating view models for the application.
///
/// This class' purpose is mainly to clean up dependency injection by taking that reponsibility from classes that should
/// not have knowledge of each of its view model's dendencies.
class ApplicationViewModelFactory {

    func makeDetailViewModel() -> DetailViewModel {
        return DetailViewModel()
    }

    func makeSelectionViewModel() -> SelectionViewModel {
        return SelectionViewModel()
    }

}
