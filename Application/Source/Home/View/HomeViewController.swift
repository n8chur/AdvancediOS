import UIKit
import Presentations
import RxSwift
import RxCocoa
import Core

class HomeViewController: UIViewController, ViewController {

    typealias ViewModelType = HomeViewModel

    let viewModel: HomeViewModel

    let themeProvider: ThemeProvider

    private let uiScheduler = MainScheduler.instance

    private(set) lazy var homeView: HomeView = {
        return HomeView(frame: UIScreen.main.bounds)
    }()

    required init(viewModel: HomeViewModel, themeProvider: ThemeProvider) {
        self.viewModel = viewModel
        self.themeProvider = themeProvider

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.testText
            .bind(to: homeView.label.rx.text)
            .disposed(by: disposeBag)
        viewModel.image
            .bind(to: homeView.imageView.rx.image)
            .disposed(by: disposeBag)
        viewModel.presentDetailTitle
            .bind(to: homeView.detailButton.rx.title())
            .disposed(by: disposeBag)

        homeView.detailButton.rx.bind(to: viewModel.presentDetail, input: true)

        rx.isAppeared
            .bind(to: viewModel.isActive)
            .disposed(by: disposeBag)

        themeProvider.bindToStyleable(self) { HomeViewControllerStyle(theme: $0) }
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

    private let disposeBag = DisposeBag()

}

protocol HomeViewControllerFactoryProtocol: DetailViewControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }

    func makeHomeViewController(viewModel: HomeViewModel) -> HomeViewController
}

extension HomeViewControllerFactoryProtocol {

    func makeHomeViewController(viewModel: HomeViewModel) -> HomeViewController {
        return HomeViewController(viewModel: viewModel, themeProvider: themeProvider)
    }

}
