import Quick
import Nimble
import RxSwift
import Core

@testable import Application

class FoodInfoPresenterSpec: QuickSpec {
    override func spec() {

        describe("FoodInfoPresentingViewModel") {
            describe("makePresentFoodInfo()") {

                var presentingViewModel: StubFoodInfoPresentingViewModel!
                var presenter: StubFoodInfoPresenter!

                beforeEach {
                    presentingViewModel = StubFoodInfoPresentingViewModel()
                    presenter = StubFoodInfoPresenter()

                    presentingViewModel.foodInfoPresenter = presenter
                }

                it("should call the presenter to create a view model") {
                    presentingViewModel.presentFoodInfo.execute(false)

                    expect(presentingViewModel.factory.makeViewModel.value).notTo(beNil())
                }

                it("should call the presenter to create a presentation context") {
                    presentingViewModel.presentFoodInfo.execute(false)

                    expect(presenter.foodInfoPresentation.value).to(be(presentingViewModel.factory.makeViewModel.value))
                }

                it("should call the setup block") {
                    presentingViewModel.presentFoodInfo.execute(false)

                    expect(presentingViewModel.setupViewModel.value).to(be(presentingViewModel.factory.makeViewModel.value))
                }
            }
        }

    }
}
