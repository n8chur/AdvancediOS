import UIKit
import RxSwift
import RxCocoa
import Core
import Logger

class TabBarChildNavigationController<ViewModelType: TabBarChildViewModel>: UINavigationController, UINavigationControllerDelegate {

    let viewModel: ViewModelType

    let themeProvider: ThemeProvider

    var statusBarStyle: UIStatusBarStyle = .default

    init(viewModel: ViewModelType, themeProvider: ThemeProvider) {
        self.viewModel = viewModel
        self.themeProvider = themeProvider

        super.init(nibName: nil, bundle: nil)

        viewModel.tabBarItemTitle
            .bind(to: tabBarItem.rx.title)
            .disposed(by: disposeBag)

        self.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        rx.isAppeared
            .emit(to: viewModel.isActive)
            .disposed(by: disposeBag)

        themeProvider.bindToStyleable(self) { TabBarChildNavigationStyle<ViewModelType>(theme: $0) }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        Log.info(Logger.Context.application, "Showing \(NSStringFromClass(type(of: viewController)))")
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    override init(rootViewController: UIViewController) { fatalError("\(#function) not implemented.") }

    private let disposeBag = DisposeBag()

}
