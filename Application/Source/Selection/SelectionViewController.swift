import UIKit
import Presentations
import RxSwift
import Action
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

        viewModel.submitTitle
            .bind(to: selectionView.submitButton.rx.title())
            .disposed(by: disposeBag)
        selectionView.submitButton.rx.bind(to: viewModel.submit, input: ())

        selectionView.textField.text = viewModel.input.value
        selectionView.textField.rx.text
            .bind(to: viewModel.input)
            .disposed(by: disposeBag)
        rx.isAppeared
            .bind(to: viewModel.isActive)
            .disposed(by: disposeBag)

        themeProvider.bindToStyleable(self) { SelectionViewControllerStyle(theme: $0) }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.selectionView.textField.becomeFirstResponder()
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

    private let disposeBag = DisposeBag()

}

protocol SelectionViewControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }

    func makeSelectionViewController(viewModel: SelectionViewModel) -> SelectionViewController
}

extension SelectionViewControllerFactoryProtocol {

    func makeSelectionViewController(viewModel: SelectionViewModel) -> SelectionViewController {
        return SelectionViewController(viewModel: viewModel, themeProvider: themeProvider)
    }

}
