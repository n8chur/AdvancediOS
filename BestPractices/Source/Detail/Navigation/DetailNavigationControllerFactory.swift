protocol DetailNavigationControllerFactory: DetailViewControllerFactoryProtocol { }

extension DetailNavigationControllerFactory {

    func makeDetailNavigationController(navigationModel: DetailNavigationModel) -> TabBarChildNavigationController {
        return TabBarChildNavigationController(navigationModel: navigationModel)
    }

}
