import Quick
import Nimble
import RxSwift
import Core

@testable import Application

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
                    presentingViewModel.presentSelection.execute(false)

                    expect(presentingViewModel.factory.makeViewModel.value).notTo(beNil())
                }

                it("should call the presenter to create a presentation context") {
                    presentingViewModel.presentSelection.execute(false)

                    expect(presenter.selectionPresentation.value).to(be(presentingViewModel.factory.makeViewModel.value))
                }

                it("should call the setup block") {
                    presentingViewModel.presentSelection.execute(false)

                    expect(presentingViewModel.setupViewModel.value).to(be(presentingViewModel.factory.makeViewModel.value))
                }
            }
        }

    }
}
