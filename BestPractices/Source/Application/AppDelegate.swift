import UIKit
import Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var coordinator: ApplicationCoordinator!
    private var viewModel: ApplicationViewModel!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let coordinator = ApplicationCoordinator(window: window)
        self.coordinator = coordinator

        let viewModel = ApplicationViewModel()
        self.viewModel = viewModel

        coordinator.start.apply(viewModel).start()

        return true
    }

}
