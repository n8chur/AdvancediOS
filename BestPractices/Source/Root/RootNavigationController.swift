import UIKit
import ReactiveSwift
import Core

class RootNavigationController: UINavigationController {

    let navigationModel: RootNavigationModel

    let rootViewController: RootViewController

    required init(navigationModel: RootNavigationModel) {
        self.navigationModel = navigationModel

        rootViewController = RootViewController(viewModel: navigationModel.rootViewModel)

        super.init(nibName: nil, bundle: nil)

        viewControllers = [ rootViewController ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationModel.isActive <~ isAppearedProducer()
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
