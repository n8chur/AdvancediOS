import UIKit
import Presentations
import RxCocoa
import RxSwift
import Action
import Core

class DetailViewController: UIViewController, ViewController {

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

        viewModel.foodListTitle
            .bind(to: detailView.foodListTitle.rx.text)
            .disposed(by: disposeBag)
        viewModel.foodListText
            .bind(to: detailView.foodList.rx.text)
            .disposed(by: disposeBag)
        viewModel.foodInfoButtonTitle
            .bind(to: detailView.foodInfoButton.rx.title())
            .disposed(by: disposeBag)

        detailView.button.rx.bind(to: viewModel.presentSelection, input: true)
        detailView.foodInfoButton.rx.bind(to: viewModel.presentFoodTable, input: true)

        rx.isAppeared
            .bind(to: viewModel.isActive)
            .disposed(by: disposeBag)

        themeProvider.bindToStyleable(self) { DetailViewControllerStyle(theme: $0) }
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

    private let disposeBag = DisposeBag()

}

protocol DetailViewControllerFactoryProtocol: SelectionViewControllerFactoryProtocol, FoodTableViewControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }

    func makeDetailViewController(viewModel: DetailViewModel) -> DetailViewController
}

extension DetailViewControllerFactoryProtocol {

    func makeDetailViewController(viewModel: DetailViewModel) -> DetailViewController {
        return DetailViewController(viewModel: viewModel, themeProvider: themeProvider)
    }

    func makeFoodTableViewController(viewModel: FoodTableViewModel) -> FoodTableViewController {
        return FoodTableViewController(viewModel: viewModel, themeProvider: themeProvider)
    }

}
