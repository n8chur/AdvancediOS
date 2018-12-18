import Quick
import Nimble
import ReactiveSwift
import Result

@testable import Application

class SelectionViewModelSpec: QuickSpec {
    override func spec() {

        let defaultValue = "Test default value"

        var viewModel: SelectionViewModel!

        beforeEach {
            viewModel = SelectionViewModel(defaultValue: defaultValue)
        }

        describe("SelectionViewModel") {
            it("should initialize with a false isActive") {
                expect(viewModel.isActive.value).to(beFalse())
            }

            describe("input") {
                it("should initialize as the default value") {
                    expect(viewModel.input.value).to(equal(defaultValue))
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
                        let newValue = "New test value"
                        viewModel.input.value = newValue

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

                        expect(sentValue).to(equal(newValue))
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
