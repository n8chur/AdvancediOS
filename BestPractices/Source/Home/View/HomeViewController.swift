import UIKit
import Presentations
import ReactiveCocoa
import ReactiveSwift
import Core

class HomeViewController: UIViewController, ViewController {

    typealias ViewModelType = HomeViewModel

    let viewModel: HomeViewModel

    let themeProvider: ThemeProvider

    private let uiScheduler = UIScheduler()

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

        homeView.label.reactive.text <~ viewModel.testText.signal
        homeView.imageView.reactive.image <~ viewModel.image
        homeView.detailButton.reactive.title <~ viewModel.presentDetailTitle

        homeView.detailButton.reactive.pressed = CocoaAction(viewModel.presentDetail)

        viewModel.isActive <~ reactive.isAppeared

        themeProvider.bindStyle(for: self)
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}

protocol HomeViewControllerFactoryProtocol: DetailViewControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }
}

extension HomeViewControllerFactoryProtocol {

    func makeHomeViewController(viewModel: HomeViewModel) -> HomeViewController {
        return HomeViewController(viewModel: viewModel, themeProvider: themeProvider)
    }

}
