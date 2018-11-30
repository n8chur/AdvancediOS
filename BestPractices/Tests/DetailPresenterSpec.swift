import Quick
import Nimble
import ReactiveSwift
import Result

@testable import BestPractices

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
                    let viewModel = MutableProperty<DetailViewModel?>(nil)
                    viewModel <~ presenter.makeDetailViewModelSignal

                    presentingViewModel.presentDetail.apply().start()

                    expect(viewModel.value).notTo(beNil())
                }

                it("should call the presenter to create a presentation context") {
                    let viewModel = MutableProperty<DetailViewModel?>(nil)
                    viewModel <~ presenter.detailPresentationContextSignal

                    presentingViewModel.presentDetail.apply().start()

                    expect(viewModel.value).notTo(beNil())
                }

                it("should call the setup block") {
                    let viewModel = MutableProperty<DetailViewModel?>(nil)
                    viewModel <~ presentingViewModel.setupViewModelSignal

                    presentingViewModel.presentDetail.apply().start()

                    expect(viewModel.value).notTo(beNil())
                }
            }
        }

    }
}
