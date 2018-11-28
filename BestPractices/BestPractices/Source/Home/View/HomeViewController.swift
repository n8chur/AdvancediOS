import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift

class HomeViewController: UIViewController, ViewController {

    typealias ViewModelType = HomeViewModel

    let viewModel: HomeViewModel

    private let uiScheduler = UIScheduler()

    private(set) lazy var homeView: HomeView = {
        return HomeView(frame: UIScreen.main.bounds)
    }()

    required init(viewModel: HomeViewModel) {
        self.viewModel = viewModel

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
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}

protocol HomeViewControllerFactoryProtocol: DetailViewControllerFactoryProtocol { }

extension HomeViewControllerFactoryProtocol {

    func makeHomeViewController(viewModel: HomeViewModel) -> HomeViewController {
        return HomeViewController(viewModel: viewModel)
    }

}
