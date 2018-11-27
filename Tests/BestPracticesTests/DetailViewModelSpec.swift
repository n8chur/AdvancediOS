import Quick
import Nimble
import ReactiveSwift
import Result
import Core

@testable import BestPractices

class DetailViewModelSpec: QuickSpec {
    override func spec() {

        var viewModel: DetailViewModel!

        beforeEach {
            viewModel = DetailViewModel()
        }

        describe("DetailViewModel") {
            it("should initialize with a false isActive") {
                expect(viewModel.isActive.value).to(beFalse())
            }

            describe("selectionResult") {
                it("should intialize as nil") {
                    expect(viewModel.selectionResult.value).to(beNil())
                }

                it("should update with the value of a selection presentation") {
                    let presenter = StubSelectionPresenter()
                    viewModel.selectionPresenter = presenter

                    let selectionValue = "Test selection input"

                    presenter.selectionPresentationContextSignal.observeValues { viewModel in
                        viewModel.input.value = selectionValue
                        viewModel.submit.apply().start()
                    }

                    viewModel.presentSelection.apply().start()

                    expect(viewModel.selectionResult.value).to(equal(selectionValue))
                }
            }

            describe("title") {
                it("should be the correct value") {
                    expect(viewModel.title.value).to(equal(L10n.Detail.title))
                }
            }
        }

    }
}
