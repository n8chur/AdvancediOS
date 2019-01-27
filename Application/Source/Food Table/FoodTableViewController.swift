import UIKit
import Presentations
import RxSwift
import Action
import Core

class FoodTableViewController: UIViewController, ViewController {

    let viewModel: FoodTableViewModel

    let themeProvider: ThemeProvider

    required init(viewModel: FoodTableViewModel, themeProvider: ThemeProvider) {
        self.viewModel = viewModel
        self.themeProvider = themeProvider

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        themeProvider.bindToStyleable(self) { FoodTableViewControllerStyle(theme: $0) }
    }

    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }

    private let disposeBag = DisposeBag()

}

protocol FoodTableViewControllerFactoryProtocol {
    var themeProvider: ThemeProvider { get }

    func makeFoodTableViewController(viewModel: FoodTableViewModel) -> FoodTableViewController
}

extension FoodTableViewControllerFactoryProtocol {

    func makeFoodTableViewController(viewModel: FoodTableViewModel) -> FoodTableViewController {
        return FoodTableViewController(viewModel: viewModel, themeProvider: themeProvider)
    }

}
