import UIKit
import ReactiveSwift
import Core

class TabBarChildNavigationController: UINavigationController {

    let viewModel: TabBarChildViewModel

    let themeProvider: ThemeProvider

    var statusBarStyle: UIStatusBarStyle = .default

    required init(viewModel: TabBarChildViewModel, themeProvider: ThemeProvider) {
        self.viewModel = viewModel
        self.themeProvider = themeProvider

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem.reactive.title <~ viewModel.tabBarItemTitle

        viewModel.isActive <~ reactive.isAppeared

        themeProvider.bindToStyleable(self) { TabBarChildNavigationStyle(theme: $0) }
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

protocol TabBarChildNavigationControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }
}

extension TabBarChildNavigationControllerFactoryProtocol {

    func makeTabBarChildNavigationController(viewModel: TabBarChildViewModel) -> TabBarChildNavigationController {
        return TabBarChildNavigationController(viewModel: viewModel, themeProvider: themeProvider)
    }

}
