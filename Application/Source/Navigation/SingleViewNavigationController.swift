import UIKit
import Core
import Logger

class SingleViewNavigationController: UINavigationController {

    let themeProvider: ThemeProvider

    var statusBarStyle: UIStatusBarStyle = .default

    required init(rootViewController: UIViewController, themeProvider: ThemeProvider) {
        self.themeProvider = themeProvider

        super.init(nibName: nil, bundle: nil)

        self.delegate = self

        self.viewControllers = [ rootViewController ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        themeProvider.bindToStyleable(self) { SingleViewNavigationStyle(theme: $0) }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    override init(rootViewController: UIViewController) { fatalError("\(#function) not implemented.") }

}

extension SingleViewNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        Log.info(Logger.Context.application, "Showing \(NSStringFromClass(type(of: viewController)))")
    }

}

protocol SingleViewNavigationControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }
}

extension SingleViewNavigationControllerFactoryProtocol {

    func makeSingleViewNavigationController(rootViewController: UIViewController) -> SingleViewNavigationController {
        return SingleViewNavigationController(rootViewController: rootViewController, themeProvider: themeProvider)
    }

}
