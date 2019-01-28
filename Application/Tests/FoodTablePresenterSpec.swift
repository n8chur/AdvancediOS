import Quick
import Nimble
import RxSwift
import Core

@testable import Application

class FoodTablePresenterSpec: QuickSpec {
    override func spec() {

        describe("FoodTablePresentingViewModel") {
            describe("makePresentFoodTable()") {

                var presentingViewModel: StubFoodTablePresentingViewModel!
                var presenter: StubFoodTablePresenter!

                beforeEach {
                    presentingViewModel = StubFoodTablePresentingViewModel()
                    presenter = StubFoodTablePresenter()

                    presentingViewModel.foodTablePresenter = presenter
                }

                it("should call the presenter to create a view model") {
                    presentingViewModel.presentFoodTable.execute(false)

                    expect(presentingViewModel.factory.makeViewModel.value).notTo(beNil())
                }

                it("should call the presenter to create a presentation context") {
                    presentingViewModel.presentFoodTable.execute(false)

                    expect(presenter.foodTablePresentation.value).to(be(presentingViewModel.factory.makeViewModel.value))
                }

                it("should call the setup block") {
                    presentingViewModel.presentFoodTable.execute(false)

                    expect(presentingViewModel.setupViewModel.value).to(be(presentingViewModel.factory.makeViewModel.value))
                }
            }
        }

    }
}
