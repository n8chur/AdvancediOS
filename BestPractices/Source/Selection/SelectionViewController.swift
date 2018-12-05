import UIKit
import Presentations
import ReactiveCocoa
import ReactiveSwift
import Core

class SelectionViewController: UIViewController, ViewController {

    typealias ViewModelType = SelectionViewModel

    let viewModel: SelectionViewModel

    let themeProvider: ThemeProvider

    private(set) lazy var selectionView: SelectionView = {
        return SelectionView(frame: UIScreen.main.bounds)
    }()

    required init(viewModel: SelectionViewModel, themeProvider: ThemeProvider) {
        self.viewModel = viewModel
        self.themeProvider = themeProvider

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

        themeProvider.bindStyle(for: self)
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

protocol SelectionViewControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }
}

extension SelectionViewControllerFactoryProtocol {

    func makeSelectionViewController(viewModel: SelectionViewModel) -> SelectionViewController {
        return SelectionViewController(viewModel: viewModel, themeProvider: themeProvider)
    }

}
