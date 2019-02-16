import RxCocoa
import Presentations

@testable import Application

class StubFoodInfoPresentingViewModel: FoodInfoPresentingViewModel {

    let setupViewModel = BehaviorRelay<FoodInfoViewModel?>(value: nil)

    weak var foodInfoPresenter: FoodInfoPresenter?

    let foods: BehaviorRelay<[Food]> = BehaviorRelay(value: [.tomatoes])

    private(set) lazy var presentFoodInfo = makePresentFoodInfo(withFactory: factory, foods: foods) { [unowned self] viewModel in
        self.setupViewModel.accept(viewModel)
    }

    let isActive = BehaviorRelay<Bool>(value: false)

    let factory = StubFoodInfoViewModelFactory()

}

class StubFoodInfoViewModelFactory: FoodInfoViewModelFactoryProtocol {

    let makeViewModel = BehaviorRelay<FoodInfoViewModel?>(value: nil)

    func makeFoodInfoViewModel(with foods: BehaviorRelay<[Food]>) -> FoodInfoViewModel {
        let viewModel = FoodInfoViewModel(with: foods)
        makeViewModel.accept(viewModel)
        return viewModel
    }
}
