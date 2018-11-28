import UIKit
import Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var coordinator: RootCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let viewModelFactory = RootViewModelFactory()
        let viewControllerFactory = RootViewControllerFactory()
        let factory = RootCoordinatorFactory(viewModel: viewModelFactory, viewController: viewControllerFactory)
        let coordinator = RootCoordinator(factory: factory)
        self.coordinator = coordinator

        window.rootViewController = coordinator.tabBarController
        window.makeKeyAndVisible()

        return true
    }

}
