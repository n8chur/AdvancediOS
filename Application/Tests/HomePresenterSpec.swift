import Quick
import Nimble
import ReactiveSwift
import Result

@testable import Application

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
                    presentingViewModel.presentHome.apply(false).start()

                    expect(presentingViewModel.factory.makeViewModel.value).notTo(beNil())
                }

                it("should call the presenter to create a presentation context closure with the same view model") {
                    presentingViewModel.presentHome.apply(false).start()

                    expect(presenter.homePresentation.value).to(be(presentingViewModel.factory.makeViewModel.value))
                }

                it("should call the setup block") {
                    presentingViewModel.presentHome.apply(false).start()

                    expect(presentingViewModel.setupViewModel.value).to(be(presentingViewModel.factory.makeViewModel.value))
                }
            }
        }

    }
}
