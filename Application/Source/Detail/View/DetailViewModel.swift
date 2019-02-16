import RxSwift
import RxCocoa
import RxExtensions
import Presentations
import Action

class DetailViewModel: ViewModel, SelectionPresentingViewModel, FoodInfoPresentingViewModel {

    let isActive = BehaviorRelay(value: false)

    weak var selectionPresenter: SelectionPresenter?
    weak var foodInfoPresenter: FoodInfoPresenter?

    let title = Property(L10n.Detail.title)

    /// The value of the result from a selection presentation.
    var selectionResult: Property<String?> { return selectionResultRelay.asProperty() }

    let presentSelectionTitle = Property(L10n.Detail.Select.title)

    let foodListTitle = Property(L10n.Detail.FoodList.title)
    let foodInfoButtonTitle = Property(L10n.Detail.FoodButton.title)

    private(set) lazy var presentFoodInfo = makePresentFoodInfo(withFactory: factory, foods: foods)

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
        withFactory: factory,
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

    typealias Factory = SelectionViewModelFactoryProtocol & FoodInfoViewModelFactoryProtocol

    init(factory: Factory) {
        self.factory = factory
    }

    private let selectionResultRelay = BehaviorRelay<String?>(value: nil)
    private let factory: Factory
    private let disposeBag = DisposeBag()

}

protocol DetailViewModelFactoryProtocol: SelectionViewModelFactoryProtocol, FoodInfoViewModelFactoryProtocol {
    func makeDetailViewModel() -> DetailViewModel
}

extension DetailViewModelFactoryProtocol {

    func makeDetailViewModel() -> DetailViewModel {
        return DetailViewModel(factory: self)
    }

}
