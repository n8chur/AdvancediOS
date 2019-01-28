import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import Application

class FoodTableViewModelSpec: QuickSpec {
    override func spec() {

        var viewModel: FoodTableViewModel!
        let foods: BehaviorRelay<[Food]> = BehaviorRelay(value: [.potatoes])

        beforeEach {
            viewModel = FoodTableViewModel(with: foods)
        }

        describe("FoodTableViewModel") {
            it("should initialize with a false isActive") {
                expect(viewModel.isActive.value).to(beFalse())
            }

            describe("foods") {
                it("should be set with the initial value") {
                    expect(viewModel.foods.value).to(equal(foods.value))
                }
            }
        }

    }
}
