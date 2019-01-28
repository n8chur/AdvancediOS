import RxCocoa
import Presentations

@testable import Application

class StubFoodTablePresenter {

    let foodTablePresentation = BehaviorRelay<FoodTableViewModel?>(value: nil)

}

extension StubFoodTablePresenter: FoodTablePresenter {

    func foodTablePresentation(of viewModel: FoodTableViewModel) -> DismissablePresentation {
        foodTablePresentation.accept(viewModel)
        return DismissablePresentation.stub()
    }

}
