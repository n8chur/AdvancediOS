import UIKit
import ReactiveSwift
import Presentations
import Core

class TabBarController<ViewModelType: ViewModel>: UITabBarController {

    let viewModel: ViewModelType

    let themeProvider: ThemeProvider

    init(viewModel: ViewModelType, themeProvider: ThemeProvider, viewControllers: [UIViewController]) {
        self.viewModel = viewModel
        self.themeProvider = themeProvider

        super.init(nibName: nil, bundle: nil)

        self.viewControllers = viewControllers
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.isActive <~ reactive.isAppeared

        themeProvider.bindToStyleable(self) { TabBarControllerStyle<ViewModelType>(theme: $0) }
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
