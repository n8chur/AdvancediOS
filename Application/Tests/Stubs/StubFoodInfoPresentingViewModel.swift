import RxCocoa
import Presentations
import RxExtensions

@testable import Application

class StubFoodInfoPresentingViewModel: FoodInfoPresentingViewModel {

    let setupViewModel = BehaviorRelay<FoodInfoViewModel?>(value: nil)

    weak var foodInfoPresenter: FoodInfoPresenter?

    private(set) lazy var presentFoodInfo = makePresentFoodInfo(withFactory: factory) { [unowned self] viewModel in
        self.setupViewModel.accept(viewModel)
    }

    let isActive = BehaviorRelay<Bool>(value: false)

    let factory = StubFoodInfoViewModelFactory()

}

class StubFoodInfoViewModelFactory: FoodInfoViewModelFactoryProtocol {

    let foods = Property<[Food]>([.tomatoes])

    let makeViewModel = BehaviorRelay<FoodInfoViewModel?>(value: nil)

    func makeFoodInfoViewModel() -> FoodInfoViewModel {
        let viewModel = FoodInfoViewModel(with: foods)
        makeViewModel.accept(viewModel)
        return viewModel
    }
}
