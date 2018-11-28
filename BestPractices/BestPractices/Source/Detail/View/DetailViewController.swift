import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift
import Result

class DetailViewController: UIViewController, ViewController {

    typealias ViewModelType = DetailViewModel

    let viewModel: DetailViewModel

    private(set) lazy var detailView: DetailView = {
        return DetailView(frame: UIScreen.main.bounds)
    }()

    required init(viewModel: DetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        detailView.title.reactive.text <~ viewModel.title
        detailView.button.reactive.title <~ viewModel.presentSelectionTitle
        detailView.selectionResult.reactive.text <~ viewModel.selectionResult

        detailView.button.reactive.pressed = CocoaAction(viewModel.presentSelection)

        viewModel.isActive <~ reactive.isAppeared
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}

protocol DetailViewControllerFactoryProtocol: SelectionViewControllerFactoryProtocol { }

extension DetailViewControllerFactoryProtocol {

    func makeDetailViewController(viewModel: DetailViewModel) -> DetailViewController {
        return DetailViewController(viewModel: viewModel)
    }

}
