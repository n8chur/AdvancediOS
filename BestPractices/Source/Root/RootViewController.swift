import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift

class RootViewController: UIViewController, ViewController {

    typealias ViewModelType = RootViewModel
    let viewModel: RootViewModel

    lazy var rootView: RootView = {
        return RootView(frame: UIScreen.main.bounds)
    }()

    required init(viewModel: RootViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        rootView.label.reactive.text <~ viewModel.testText

        viewModel.isActive <~ isAppearedProducer()
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
