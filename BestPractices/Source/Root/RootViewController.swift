import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift

class RootViewController: UIViewController, ViewController {

    typealias ViewModelType = RootViewModel
    let viewModel: RootViewModel

    private(set) lazy var rootView: RootView = {
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
        rootView.imageView.reactive.image <~ viewModel.image
        rootView.button.reactive.title <~ viewModel.presentDetailsTitle

        rootView.button.reactive.pressed = CocoaAction(viewModel.presentDetails)

        viewModel.isActive <~ reactive.isAppeared
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
