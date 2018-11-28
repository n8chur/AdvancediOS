import Core

/// A factory for creating view controllers for the detail flow.
///
/// This class' purpose is mainly to clean up dependency injection by taking that reponsibility from classes that should
/// not have knowledge of each of its view controller's dependencies.
class DetailViewControllerFactory: DetailNavigationControllerFactory { }
