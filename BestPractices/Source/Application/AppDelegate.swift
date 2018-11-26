import UIKit
import Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var coordinator: ApplicationCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let viewModelFactory = ApplicationViewModelFactory()
        let coordinator = ApplicationCoordinator(viewModelFactory: viewModelFactory, window: window)
        self.coordinator = coordinator

        coordinator.start()

        return true
    }

}
