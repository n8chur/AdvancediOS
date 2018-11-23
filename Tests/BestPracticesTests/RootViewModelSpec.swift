import Quick
import Nimble
import ReactiveSwift

@testable import BestPractices

class RootViewModelSpec: QuickSpec {
    override func spec() {

        var rootViewModel: RootViewModel!

        beforeEach {
            rootViewModel = RootViewModel()
        }

        describe("RootViewModel") {
            it("should initialize with a false isActive") {
                expect(rootViewModel.isActive.value).to(beFalse())
            }

            describe("testText") {
                context("when isActive is true") {
                    it("should send the correct value") {
                        expect(rootViewModel.testText.value).to(beNil())

                        rootViewModel.isActive.value = true

                        expect(rootViewModel.testText.value).toEventually(equal(L10n.Root.testText), timeout: 2)
                    }
                }
            }
        }

    }
}
