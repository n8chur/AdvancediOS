import Quick
import Nimble
import RxSwift
import RxCocoa

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
                        viewModel.input.accept(newValue)

                        let submitValue = BehaviorRelay<String??>(value: nil)
                        _ = viewModel.submit.elements.bind(to: submitValue)

                        viewModel.submit.execute(())

                        guard let sentValue = submitValue.value else {
                            fail("No value sent.")
                            return
                        }

                        expect(sentValue).to(equal(newValue))
                    }
                }

                context("when input is non-nil") {
                    it("should send the value") {
                        let input = "Test input value."
                        viewModel.input.accept(input)

                        let submitValue = BehaviorRelay<String?>(value: nil)
                        _ = viewModel.submit.elements.bind(to: submitValue)

                        viewModel.submit.execute(())

                        expect(submitValue.value).to(equal(input))
                    }
                }
            }
        }

    }
}
