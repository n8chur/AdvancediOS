import UIKit
import Presentations
import ReactiveCocoa
import ReactiveSwift
import Result
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

        detailView.title.reactive.text <~ viewModel.title
        detailView.button.reactive.title <~ viewModel.presentSelectionTitle
        detailView.selectionResult.reactive.text <~ viewModel.selectionResult

        detailView.button.reactive.pressed = CocoaAction(viewModel.presentSelection, input: true)

        viewModel.isActive <~ reactive.isAppeared

        themeProvider.bindToStyleable(self) { DetailViewControllerStyle(theme: $0) }
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

}

protocol DetailViewControllerFactoryProtocol: SelectionViewControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }
}

extension DetailViewControllerFactoryProtocol {

    func makeDetailViewController(viewModel: DetailViewModel) -> DetailViewController {
        return DetailViewController(viewModel: viewModel, themeProvider: themeProvider)
    }

}
