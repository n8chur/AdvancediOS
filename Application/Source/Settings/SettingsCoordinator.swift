import UIKit
import Presentations
import ReactiveCocoa
import ReactiveSwift
import Result

/// The flow coordinator for the settings flow.
///
/// This class is responsible for:
/// - Instantiating the detail navigation controller
/// - Handling presentation of views controllers in the navigation controller
/// - Forwarding view model creation to the view model factory it was initialized with
/// - Forwarding view controller creation to the view controller factory it was initialized with
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
