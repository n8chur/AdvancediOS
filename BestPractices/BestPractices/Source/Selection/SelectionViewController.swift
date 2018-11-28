import UIKit
import Core
import ReactiveCocoa
import ReactiveSwift

class SelectionViewController: UIViewController, ViewController {

    typealias ViewModelType = SelectionViewModel

    let viewModel: SelectionViewModel

    private(set) lazy var selectionView: SelectionView = {
        return SelectionView(frame: UIScreen.main.bounds)
    }()

    required init(viewModel: SelectionViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = selectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        selectionView.submitButton.reactive.title <~ viewModel.submitTitle
        selectionView.submitButton.reactive.pressed = CocoaAction(viewModel.submit)

        viewModel.input <~ selectionView.textField.reactive.continuousTextValues
        viewModel.isActive <~ reactive.isAppeared
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.selectionView.textField.becomeFirstResponder()
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}
