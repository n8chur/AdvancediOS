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

    private let factory: SettingsCoordinatorFactory

    init(factory: SettingsCoordinatorFactory) {
        self.factory = factory

        let navigationModel = factory.viewModel.makeSettingsNavigationModel()
        navigationController = factory.viewController.makeSettingsNavigationController(navigationModel: navigationModel)

        navigationModel.settingsPresenter = self
        navigationModel.presentSettings.apply().start()
    }

}

extension SettingsCoordinator: SettingsPresenter {

    func makeSettingsViewModel() -> SettingsViewModel {
        return factory.viewModel.makeSettingsViewModel()
    }

    func settingsPresentationContext(of viewModel: SettingsViewModel) -> DismissablePresentationContext {
        let viewController = factory.viewController.makeSettingsViewController(viewModel: viewModel)
        let presentation = navigationController.makePushPresentation(of: viewController)

        // Do not present/dismiss animated since this is the root view controller.
        return DismissablePresentationContext(presentation: presentation, presentAnimated: false, dismissAnimated: false)
    }

}
