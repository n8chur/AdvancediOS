import Quick
import Nimble
import ReactiveSwift
import Result

@testable import BestPractices

class SelectionViewModelSpec: QuickSpec {
    override func spec() {

        var viewModel: SelectionViewModel!

        beforeEach {
            viewModel = SelectionViewModel()
        }

        describe("SelectionViewModel") {
            it("should initialize with a false isActive") {
                expect(viewModel.isActive.value).to(beFalse())
            }

            describe("input") {
                it("should initialize as nil") {
                    expect(viewModel.input.value).to(beNil())
                }
            }

            describe("submitTitle") {
                it("should be the correct value") {
                    expect(viewModel.submitTitle.value).to(equal(L10n.Selection.Submit.title))
                }
            }

            describe("submit") {
                context("when input is nil") {
                    it("should send the value") {
                        var submitValue: String??
                        viewModel.submit.apply()
                            .on(value: { value in
                                submitValue = value
                            })
                            .start()

                        guard let sentValue = submitValue else {
                            fail("No value sent.")
                            return
                        }

                        expect(sentValue).to(beNil())
                    }
                }

                context("when input is non-nil") {
                    it("should send the value") {
                        let input = "Test input value."
                        viewModel.input.value = input

                        var sentValue: String?
                        viewModel.submit.apply()
                            .on(value: { value in
                                sentValue = value
                            })
                            .start()

                        expect(sentValue).to(equal(input))
                    }
                }
            }
        }

    }
}
