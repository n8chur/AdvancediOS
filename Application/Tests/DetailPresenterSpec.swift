import Quick
import Nimble
import RxSwift

@testable import Application

class DetailPresenterSpec: QuickSpec {
    override func spec() {

        describe("DetailPresentingViewModel") {
            describe("makePresentDetail()") {

                var presentingViewModel: StubDetailPresentingViewModel!
                var presenter: StubDetailPresenter!

                beforeEach {
                    presentingViewModel = StubDetailPresentingViewModel()
                    presenter = StubDetailPresenter()

                    presentingViewModel.detailPresenter = presenter
                }

                it("should call the presenter to create a view model") {
                    presentingViewModel.presentDetail.apply(false).start()

                    expect(presentingViewModel.factory.makeViewModel.value).notTo(beNil())
                }

                it("should call the presenter to create a presentation context") {
                    presentingViewModel.presentDetail.apply(false).start()

                    expect(presenter.detailPresentation.value).to(be(presentingViewModel.factory.makeViewModel.value))
                }

                it("should call the setup block") {
                    presentingViewModel.presentDetail.apply(false).start()

                    expect(presentingViewModel.setupViewModel.value).to(be(presentingViewModel.factory.makeViewModel.value))
                }
            }
        }

    }
}
