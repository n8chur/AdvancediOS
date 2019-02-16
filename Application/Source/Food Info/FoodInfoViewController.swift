import UIKit
import Presentations
import RxSwift
import Action
import Core

class FoodInfoViewController: UITableViewController, ViewController {

    let viewModel: FoodInfoViewModel

    let themeProvider: ThemeProvider

    required init(viewModel: FoodInfoViewModel, themeProvider: ThemeProvider) {
        self.viewModel = viewModel
        self.themeProvider = themeProvider

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        viewModel.foods
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { _, food, cell in
                cell.textLabel?.text = food.name
            }
            .disposed(by: disposeBag)

        rx.isAppeared
            .bind(to: viewModel.isActive)
            .disposed(by: disposeBag)

        themeProvider.bindToStyleable(self) { FoodInfoViewControllerStyle(theme: $0) }
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

    private let cellIdentifier = "FoodCell"
    private let disposeBag = DisposeBag()

}

protocol FoodInfoViewControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }

    func makeFoodInfoViewController(viewModel: FoodInfoViewModel) -> FoodInfoViewController
}

extension FoodInfoViewControllerFactoryProtocol {

    func makeFoodInfoViewController(viewModel: FoodInfoViewModel) -> FoodInfoViewController {
        return FoodInfoViewController(viewModel: viewModel, themeProvider: themeProvider)
    }

}
