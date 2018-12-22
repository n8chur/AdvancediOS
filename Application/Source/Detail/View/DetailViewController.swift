import UIKit
import Presentations
import RxCocoa
import RxSwift
import Action
import Core

class DetailViewController: UIViewController, ViewController {

    typealias ViewModelType = DetailViewModel

    let viewModel: DetailViewModel

    let themeProvider: ThemeProvider

    private(set) lazy var detailView: DetailView = {
        return DetailView(frame: UIScreen.main.bounds)
    }()

    required init(viewModel: DetailViewModel, themeProvider: ThemeProvider) {
        self.viewModel = viewModel
        self.themeProvider = themeProvider

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.title
            .bind(to: detailView.title.rx.text)
            .disposed(by: disposeBag)
        viewModel.presentSelectionTitle
            .bind(to: detailView.button.rx.title())
            .disposed(by: disposeBag)
        viewModel.selectionResult
            .bind(to: detailView.selectionResult.rx.text)
            .disposed(by: disposeBag)

        detailView.button.rx.bind(to: viewModel.presentSelection, input: true)

        rx.isAppeared
            .emit(to: viewModel.isActive)
            .disposed(by: disposeBag)

        themeProvider.bindToStyleable(self) { DetailViewControllerStyle(theme: $0) }
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

    private let disposeBag = DisposeBag()

}

protocol DetailViewControllerFactoryProtocol: SelectionViewControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }

    func makeDetailViewController(viewModel: DetailViewModel) -> DetailViewController
}

extension DetailViewControllerFactoryProtocol {

    func makeDetailViewController(viewModel: DetailViewModel) -> DetailViewController {
        return DetailViewController(viewModel: viewModel, themeProvider: themeProvider)
    }

}
