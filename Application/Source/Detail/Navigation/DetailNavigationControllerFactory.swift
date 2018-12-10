protocol DetailNavigationControllerFactory: TabBarChildNavigationControllerFactoryProtocol, DetailViewControllerFactoryProtocol, SingleViewNavigationControllerFactoryProtocol { }

extension DetailNavigationControllerFactory {

    func makeDetailNavigationController(navigationModel: DetailNavigationModel) -> TabBarChildNavigationController {
        return makeTabBarChildNavigationController(viewModel: navigationModel)
    }

}
