import Quick
import Nimble
import ReactiveSwift
import Result
import Core

@testable import BestPractices

class SelectionPresenterSpec: QuickSpec {
    override func spec() {

        describe("SelectionPresentingViewModel") {
            describe("makePresentSelection()") {

                var presentingViewModel: StubSelectionPresentingViewModel!
                var presenter: StubSelectionPresenter!

                beforeEach {
                    presentingViewModel = StubSelectionPresentingViewModel()
                    presenter = StubSelectionPresenter()

                    presentingViewModel.selectionPresenter = presenter
                }

                it("should call the presenter to create a view model") {
                    presentingViewModel.presentSelection.apply().start()

                    expect(presenter.makeSelectionViewModelCall.value).notTo(beNil())
                }

                it("should call the presenter to create a presentation context") {
                    presentingViewModel.presentSelection.apply().start()

                    expect(presenter.selectionPresentationContext.value).to(be(presenter.makeSelectionViewModelCall.value))
                }

                it("should call the setup block") {
                    presentingViewModel.presentSelection.apply().start()

                    expect(presentingViewModel.setupViewModel.value).to(be(presenter.makeSelectionViewModelCall.value))
                }
            }
        }

    }
}
