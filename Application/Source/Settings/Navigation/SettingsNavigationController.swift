import Core
import Presentations

class SettingsNavigationController: TabBarChildNavigationController<SettingsNavigationModel> {

    init(navigationModel: SettingsNavigationModel, navigationControllerFactory: SettingsNavigationControllerFactoryProtocol, themeProvider: ThemeProvider) {
        self.factory = navigationControllerFactory

        super.init(viewModel: navigationModel, themeProvider: themeProvider)

        navigationModel.settingsPresenter = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.presentSettings.apply(false).start()
    }

    private let factory: SettingsNavigationControllerFactoryProtocol

}

extension SettingsNavigationController: SettingsPresenter {

    func settingsPresentation(of viewModel: SettingsViewModel) -> DismissablePresentation {
        let viewController = factory.makeSettingsViewController(viewModel: viewModel)
        return makePushPresentation(of: viewController)
    }

}

protocol SettingsNavigationControllerFactoryProtocol: SettingsViewControllerFactoryProtocol { }
