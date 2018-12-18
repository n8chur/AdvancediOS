import UIKit
import Presentations
import ReactiveCocoa
import ReactiveSwift
import Result

/// The flow coordinator for the settings flow.
///
/// This class is responsible for:
/// - Instantiating the navigation controller
/// - Generating presentations of view controllers when requested by a view model
class SettingsCoordinator {

    let navigationController: TabBarChildNavigationController

    init(navigationModelFactory: SettingsNavigationModelFactoryProtocol, navigationControllerFactory: SettingsNavigationControllerFactoryProtocol) {
        self.factory = navigationControllerFactory

        let navigationModel = navigationModelFactory.makeSettingsNavigationModel()
        navigationController = navigationControllerFactory.makeSettingsNavigationController(navigationModel: navigationModel)

        navigationModel.settingsPresenter = self
        navigationModel.presentSettings.apply(false).start()
    }

    private let factory: SettingsNavigationControllerFactoryProtocol

}

extension SettingsCoordinator: SettingsPresenter {

    func settingsPresentation(of viewModel: SettingsViewModel) -> DismissablePresentation {
        let viewController = factory.makeSettingsViewController(viewModel: viewModel)
        return navigationController.makePushPresentation(of: viewController)
    }

}
