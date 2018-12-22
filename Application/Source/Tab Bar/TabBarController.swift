import UIKit
import RxSwift
import RxCocoa
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

        rx.isAppeared
            .bind(to: viewModel.isActive)
            .disposed(by: disposeBag)

        themeProvider.bindToStyleable(self) { TabBarControllerStyle<ViewModelType>(theme: $0) }
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

    private let disposeBag = DisposeBag()

}
