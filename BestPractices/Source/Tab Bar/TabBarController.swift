import UIKit
import ReactiveSwift
import Presentations

class TabBarController: UITabBarController {

    let viewModel: ViewModel

    required init(viewModel: ViewModel, viewControllers: [UIViewController]) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        self.viewControllers = viewControllers
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
