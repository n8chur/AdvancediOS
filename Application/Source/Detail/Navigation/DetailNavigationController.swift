import Core
import RxSwift
import Action
import Presentations

class DetailNavigationController: TabBarChildNavigationController<DetailNavigationModel> {

    init(navigationModel: DetailNavigationModel, navigationControllerFactory: DetailNavigationControllerFactoryProtocol, themeProvider: ThemeProvider) {
        self.factory = navigationControllerFactory

        super.init(viewModel: navigationModel, themeProvider: themeProvider)

        navigationModel.detailPresenter = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.presentDetail.execute(false)
    }

    private let factory: DetailNavigationControllerFactoryProtocol

}

extension DetailNavigationController: DetailPresenter {

    func detailPresentation(of viewModel: DetailViewModel) -> DismissablePresentation {
        let viewController = factory.makeDetailViewController(viewModel: viewModel)
        return makePushPresentation(of: viewController)
    }

}

extension DetailNavigationController: SelectionPresenter {

    func selectionPresentation(of viewModel: SelectionViewModel) -> DismissablePresentation {
        let viewController = factory.makeSelectionViewController(viewModel: viewModel)
        let navigationController = factory.makeSingleViewNavigationController(rootViewController: viewController)
        let presentation = makeModalPresentation(of: navigationController)
        presentation.addCancelBarButtonItem(to: viewController, animated: true)
        return presentation
    }

}

extension DetailNavigationController: FoodTablePresenter {

    func foodTablePresentation(of viewModel: FoodTableViewModel) -> DismissablePresentation {
        let viewController = factory.makeFoodTableViewController(viewModel: viewModel)
        return makePushPresentation(of: viewController)
    }

}

protocol DetailNavigationControllerFactoryProtocol: DetailViewControllerFactoryProtocol, FoodTableViewControllerFactoryProtocol, SingleViewNavigationControllerFactoryProtocol { }
