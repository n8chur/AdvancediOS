import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

/// The flow coordinator for the root of the application.
///
/// This class is responsible for:
/// - Instantiating the root tab bar controller
/// - Handling presentation of views controllers in the navigation controller
/// - Forwarding view model creation to the view model factory it was initialized with
/// - Forwarding view controller creation to the view controller factory it was initialized with
class RootCoordinator {

    let tabBarController: TabBarController

    private let homeCoordinator: HomeCoordinator
    private let detailCoordinator: DetailCoordinator
    private let settingsCoordinator: SettingsCoordinator

    init(tabBarModelFactory: RootTabBarModelFactoryProtocol, tabBarControllerFactory: RootTabBarControllerFactoryProtocol) {
        homeCoordinator = HomeCoordinator(navigationModelFactory: tabBarModelFactory, navigationControllerFactory: tabBarControllerFactory)
        detailCoordinator = DetailCoordinator(navigationModelFactory: tabBarModelFactory, navigationControllerFactory: tabBarControllerFactory)
        settingsCoordinator = SettingsCoordinator(navigationModelFactory: tabBarModelFactory, navigationControllerFactory: tabBarControllerFactory)

        let viewModel = tabBarModelFactory.makeRootTabBarViewModel()
        tabBarController = tabBarControllerFactory.makeRootTabBarController(viewModel: viewModel, homeNavigationController: homeCoordinator.navigationController, detailNavigationController: detailCoordinator.navigationController, settingsNavigationController: settingsCoordinator.navigationController)
    }

}
