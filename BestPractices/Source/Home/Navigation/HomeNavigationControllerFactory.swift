protocol HomeNavigationControllerFactory: TabBarChildNavigationControllerFactoryProtocol, HomeViewControllerFactoryProtocol, SingleViewNavigationControllerFactoryProtocol { }

extension HomeNavigationControllerFactory {

    func makeHomeNavigationController(navigationModel: HomeNavigationModel) -> TabBarChildNavigationController {
        return makeTabBarChildNavigationController(viewModel: navigationModel)
    }

}
