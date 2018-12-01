import Quick
import Nimble
import ReactiveSwift
import Result

@testable import BestPractices

class HomePresenterSpec: QuickSpec {
    override func spec() {

        describe("HomePresentingViewModel") {
            describe("makePresentHome()") {

                var presentingViewModel: StubHomePresentingViewModel!
                var presenter: StubHomePresenter!

                beforeEach {
                    presentingViewModel = StubHomePresentingViewModel()
                    presenter = StubHomePresenter()

                    presentingViewModel.homePresenter = presenter
                }

                it("should call the presenter to create a view model") {
                    presentingViewModel.presentHome.apply().start()

                    expect(presenter.makeHomeViewModelCall.value).notTo(beNil())
                }

                it("should call the presenter to create a presentation context closure with the same view model") {
                    presentingViewModel.presentHome.apply().start()

                    expect(presenter.homePresentationContext.value).to(be(presenter.makeHomeViewModelCall.value))
                }

                it("should call the setup block") {
                    presentingViewModel.presentHome.apply().start()

                    expect(presentingViewModel.setupViewModel.value).to(be(presenter.makeHomeViewModelCall.value))
                }
            }
        }

    }
}
