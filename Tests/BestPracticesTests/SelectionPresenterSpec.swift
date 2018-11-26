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

                it("should call the presenter to create a presentation") {
                    let viewModel = MutableProperty<SelectionViewModel?>(nil)
                    viewModel <~ presenter.presentationViewModelSignal

                    presentingViewModel.presentSelection.apply().start()

                    expect(viewModel.value).notTo(beNil())
                }

                it("should call the presenter to create a view model") {
                    let viewModel = MutableProperty<SelectionViewModel?>(nil)
                    viewModel <~ presenter.makeViewModelSignal

                    presentingViewModel.presentSelection.apply().start()

                    expect(viewModel.value).notTo(beNil())
                }

                it("should call the setup block") {
                    let viewModel = MutableProperty<SelectionViewModel?>(nil)
                    viewModel <~ presentingViewModel.setupViewModelSignal

                    presentingViewModel.presentSelection.apply().start()

                    expect(viewModel.value).notTo(beNil())
                }
            }
        }

    }
}
