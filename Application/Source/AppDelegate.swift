import UIKit
import Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var coordinator: RootCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let themeProvider = ThemeProvider()
        themeProvider.bindToStyleable(window) { WindowStyle(theme: $0) }

        let tabBarModelFactory = RootTabBarModelFactory(themeProvider: themeProvider)
        let tabBarControllerFactory = RootTabBarControllerFactory(themeProvider: themeProvider)
        let coordinator = RootCoordinator(tabBarModelFactory: tabBarModelFactory, tabBarControllerFactory: tabBarControllerFactory)
        self.coordinator = coordinator

        window.rootViewController = coordinator.tabBarController
        window.makeKeyAndVisible()

        return true
    }

}
