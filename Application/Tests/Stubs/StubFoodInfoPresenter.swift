import RxCocoa
import Presentations

@testable import Application

class StubFoodInfoPresenter {

    let foodInfoPresentation = BehaviorRelay<FoodInfoViewModel?>(value: nil)

}

extension StubFoodInfoPresenter: FoodInfoPresenter {

    func foodInfoPresentation(of viewModel: FoodInfoViewModel) -> DismissablePresentation {
        foodInfoPresentation.accept(viewModel)
        return DismissablePresentation.stub()
    }

}
