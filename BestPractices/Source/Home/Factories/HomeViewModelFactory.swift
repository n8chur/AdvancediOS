import Core

/// A factory for creating view models for home flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that reponsibility from classes that should
/// not have knowledge of each of its view model's dependencies.
class HomeViewModelFactory {

    func makeHomeNavigationModel() -> HomeNavigationModel {
        return HomeNavigationModel()
    }

    func makeDetailViewModel() -> DetailViewModel {
        return DetailViewModel()
    }

    func makeSelectionViewModel() -> SelectionViewModel {
        return SelectionViewModel()
    }

}
