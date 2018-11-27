import UIKit
import ReactiveSwift
import Core

class HomeNavigationController: UINavigationController {

    let navigationModel: HomeNavigationModel

    required init(navigationModel: HomeNavigationModel, homeViewController: HomeViewController) {
        self.navigationModel = navigationModel

        super.init(nibName: nil, bundle: nil)

        viewControllers = [ homeViewController ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationModel.isActive <~ reactive.isAppeared
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
