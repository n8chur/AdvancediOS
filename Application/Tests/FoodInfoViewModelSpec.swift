import Quick
import Nimble
import RxSwift
import RxCocoa
import RxExtensions

@testable import Application

class FoodInfoViewModelSpec: QuickSpec {
    override func spec() {

        var viewModel: FoodInfoViewModel!
        let foods = Property<[Food]>([.potatoes])

        beforeEach {
            viewModel = FoodInfoViewModel(with: foods)
        }

        describe("FoodInfoViewModel") {
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
