import UIKit
import Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var root: RootTabBarController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let themeProvider = ThemeProvider()
        themeProvider.bindToStyleable(window) { WindowStyle(theme: $0) }

        let tabBarModelFactory = RootTabBarModelFactory(themeProvider: themeProvider)
        let tabBarControllerFactory = RootTabBarControllerFactory(themeProvider: themeProvider)
        let viewModel = tabBarModelFactory.makeRootTabBarViewModel()
        let root = RootTabBarController(viewModel: viewModel, tabBarControllerFactory: tabBarControllerFactory, themeProvider: themeProvider)
        self.root = root

        window.rootViewController = root
        window.makeKeyAndVisible()

        return true
    }

}
