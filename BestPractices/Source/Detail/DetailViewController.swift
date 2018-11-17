import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift

class DetailViewController: UIViewController, ViewController {

    typealias ViewModelType = DetailViewModel
    let viewModel: DetailViewModel

    lazy var detailView: DetailView = {
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

        detailView.label.reactive.text <~ viewModel.title

        viewModel.isActive <~ isAppearedProducer()
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}