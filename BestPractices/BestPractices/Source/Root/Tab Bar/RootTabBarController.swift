import UIKit
import ReactiveSwift
import Core

class RootTabBarController: UITabBarController {

    let viewModel: RootTabBarViewModel

    required init(viewModel: RootTabBarViewModel, homeNavigationController: HomeNavigationController) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        viewControllers = [ homeNavigationController ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.isActive <~ reactive.isAppeared
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
