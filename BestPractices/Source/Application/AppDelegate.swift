import UIKit
import Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var coordinator: HomeCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let viewModelFactory = HomeViewModelFactory()
        let viewControllerFactory = HomeViewControllerFactory()
        let coordinator = HomeCoordinator(viewModelFactory: viewModelFactory, viewControllerFactory: viewControllerFactory)
        self.coordinator = coordinator

        window.rootViewController = coordinator.navigationController
        window.makeKeyAndVisible()

        return true
    }

}
