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

extension DetailNavigationController: FoodInfoPresenter {

    func foodInfoPresentation(of viewModel: FoodInfoViewModel) -> DismissablePresentation {
        let viewController = factory.makeFoodInfoViewController(viewModel: viewModel)
        return makePushPresentation(of: viewController)
    }

}

protocol DetailNavigationControllerFactoryProtocol: DetailViewControllerFactoryProtocol, SingleViewNavigationControllerFactoryProtocol { }
