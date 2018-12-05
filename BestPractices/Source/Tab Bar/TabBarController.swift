import UIKit
import ReactiveSwift
import Presentations
import Core

class TabBarController: UITabBarController {

    let viewModel: ViewModel

    let themeProvider: ThemeProvider

    required init(viewModel: ViewModel, themeProvider: ThemeProvider, viewControllers: [UIViewController]) {
        self.viewModel = viewModel
        self.themeProvider = themeProvider

        super.init(nibName: nil, bundle: nil)

        self.viewControllers = viewControllers
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.isActive <~ reactive.isAppeared

        themeProvider.bindToStyleable(self) { TabBarControllerStyle(theme: $0) }
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
