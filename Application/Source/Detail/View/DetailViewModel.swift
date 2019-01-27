import RxSwift
import RxCocoa
import RxExtensions
import Presentations
import Action

class DetailViewModel: ViewModel, SelectionPresentingViewModel, FoodTablePresentingViewModel {

    let isActive = BehaviorRelay(value: false)

    weak var selectionPresenter: SelectionPresenter?
    weak var foodTablePresenter: FoodTablePresenter?

    let title = Property(L10n.Detail.title)

    /// The value of the result from a selection presentation.
    var selectionResult: Property<String?> { return selectionResultRelay.asProperty() }

    let presentSelectionTitle = Property(L10n.Detail.Select.title)

    let foodListTitle = Property(L10n.Detail.FoodList.title)
    let foodInfoButtonTitle = Property(L10n.Detail.FoodButton.title)

    private(set) lazy var presentFoodTable = makePresentFoodTable(withFactory: foodTableFactory, foods: foods)

    let foods: BehaviorRelay<[Food]> = BehaviorRelay(value: [.beans, .greens, .potatoes, .tomatoes])

    private(set) lazy var foodListText: Property<String> = {
        let observable = foods.map { foods -> String in
            return foods
                .map { $0.name }
                .joined(separator: ", ")
        }
        return Property(observable, initial: "")
    }()

    private(set) lazy var presentSelection = makePresentSelection(
        withFactory: selectionFactory,
        defaultValue: { [weak self] in
            return self?.selectionResult.value
        },
        setupViewModel: { [weak self] viewModel in
            guard let self = self else { fatalError() }

            viewModel.result
                .take(1)
                .bind(to: self.selectionResultRelay)
                .disposed(by: self.disposeBag)
        })

    init(selectionFactory: SelectionViewModelFactoryProtocol, foodTableFactory: FoodTableViewModelFactoryProtocol) {
        self.selectionFactory = selectionFactory
        self.foodTableFactory = foodTableFactory
    }

    private let selectionResultRelay = BehaviorRelay<String?>(value: nil)
    private let selectionFactory: SelectionViewModelFactoryProtocol
    private let foodTableFactory: FoodTableViewModelFactoryProtocol
    private let disposeBag = DisposeBag()

}

protocol DetailViewModelFactoryProtocol: SelectionViewModelFactoryProtocol, FoodTableViewModelFactoryProtocol {
    func makeDetailViewModel() -> DetailViewModel
}

extension DetailViewModelFactoryProtocol {

    func makeDetailViewModel() -> DetailViewModel {
        return DetailViewModel(selectionFactory: self, foodTableFactory: self)
    }

}
