import RxCocoa
import Presentations

@testable import Application

class StubFoodTablePresentingViewModel: FoodTablePresentingViewModel {

    let setupViewModel = BehaviorRelay<FoodTableViewModel?>(value: nil)

    weak var foodTablePresenter: FoodTablePresenter?

    let foods: BehaviorRelay<[Food]> = BehaviorRelay(value: [.tomatoes])

    private(set) lazy var presentFoodTable = makePresentFoodTable(withFactory: factory, foods: foods) { [unowned self] viewModel in
        self.setupViewModel.accept(viewModel)
    }

    let isActive = BehaviorRelay<Bool>(value: false)

    let factory = StubFoodTableViewModelFactory()

}

class StubFoodTableViewModelFactory: FoodTableViewModelFactoryProtocol {

    let makeViewModel = BehaviorRelay<FoodTableViewModel?>(value: nil)

    func makeFoodTableViewModel(with foods: BehaviorRelay<[Food]>) -> FoodTableViewModel {
        let viewModel = FoodTableViewModel(with: foods)
        makeViewModel.accept(viewModel)
        return viewModel
    }
}
