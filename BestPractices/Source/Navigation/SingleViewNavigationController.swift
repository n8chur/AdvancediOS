import UIKit
import ReactiveSwift

class SingleViewNavigationController: UINavigationController {

    let themeProvider: ThemeProvider

    var statusBarStyle: UIStatusBarStyle = .default

    required init(rootViewController: UIViewController, themeProvider: ThemeProvider) {
        self.themeProvider = themeProvider

        super.init(nibName: nil, bundle: nil)

        self.viewControllers = [ rootViewController ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        themeProvider.bindStyle(for: self)
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

protocol SingleViewNavigationControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }
}

extension SingleViewNavigationControllerFactoryProtocol {

    func makeSingleViewNavigationController(rootViewController: UIViewController) -> SingleViewNavigationController {
        return SingleViewNavigationController(rootViewController: rootViewController, themeProvider: themeProvider)
    }

}
