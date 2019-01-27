import Core
import Presentations

class HomeNavigationController: TabBarChildNavigationController<HomeNavigationModel> {

    init(navigationModel: HomeNavigationModel, navigationControllerFactory: HomeNavigationControllerFactoryProtocol, themeProvider: ThemeProvider) {
        self.factory = navigationControllerFactory

        super.init(viewModel: navigationModel, themeProvider: themeProvider)

        navigationModel.homePresenter = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.presentHome.execute(false)
    }

    private let factory: HomeNavigationControllerFactoryProtocol

}

extension HomeNavigationController: HomePresenter {

    func homePresentation(of viewModel: HomeViewModel) -> DismissablePresentation {
        let viewController = factory.makeHomeViewController(viewModel: viewModel)
        return makePushPresentation(of: viewController)
    }

}

extension HomeNavigationController: DetailPresenter {

    func detailPresentation(of viewModel: DetailViewModel) -> DismissablePresentation {
        let viewController = factory.makeDetailViewController(viewModel: viewModel)
        return makePushPresentation(of: viewController)
    }

}

extension HomeNavigationController: FoodTablePresenter {

    func foodTablePresentation(of viewModel: FoodTableViewModel) -> DismissablePresentation {
        let viewController = factory.makeFoodTableViewController(viewModel: viewModel)
        return makePushPresentation(of: viewController)
    }

}

extension HomeNavigationController: SelectionPresenter {

    func selectionPresentation(of viewModel: SelectionViewModel) -> DismissablePresentation {
        let viewController = factory.makeSelectionViewController(viewModel: viewModel)
        let navigationController = factory.makeSingleViewNavigationController(rootViewController: viewController)
        let presentation = makeModalPresentation(of: navigationController)
        presentation.addCancelBarButtonItem(to: viewController, animated: true)
        return presentation
    }

}

protocol HomeNavigationControllerFactoryProtocol: HomeViewControllerFactoryProtocol, FoodTableViewControllerFactoryProtocol, SingleViewNavigationControllerFactoryProtocol { }
