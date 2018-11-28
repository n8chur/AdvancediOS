protocol HomeNavigationControllerFactory: HomeViewControllerFactoryProtocol { }

extension HomeNavigationControllerFactory {

    func makeHomeNavigationController(navigationModel: HomeNavigationModel) -> TabBarChildNavigationController {
        return TabBarChildNavigationController(navigationModel: navigationModel)
    }

}
