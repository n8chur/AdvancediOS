import Quick
import Nimble
import ReactiveSwift
import Result
import Core

@testable import Application

class HomeViewModelSpec: QuickSpec {
    override func spec() {

        var viewModel: HomeViewModel!

        beforeEach {
            viewModel = HomeViewModel()
        }

        describe("HomeViewModel") {
            it("should initialize with a false isActive") {
                expect(viewModel.isActive.value).to(beFalse())
            }

            describe("testText") {
                context("when isActive is true") {
                    it("should send the correct value") {
                        expect(viewModel.testText.value).to(beNil())

                        viewModel.isActive.value = true

                        expect(viewModel.testText.value).toEventually(equal(L10n.Home.testText))
                    }
                }
            }

            describe("image") {
                it("should be the n8chur logo") {
                    expect(viewModel.image.value).to(equal(Image.n8churLogo.image))
                }
            }
        }

    }
}
