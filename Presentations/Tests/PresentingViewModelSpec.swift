import Quick
import Nimble
import ReactiveSwift
import Result

@testable import Presentations

class PresentatingViewModelSpec: QuickSpec {
    override func spec() {

        describe("PresentingViewModel") {
            describe("makePresent(...)") {
                context("when the presenter is set") {
                    it("should call all of the appropriate callback functions") {
                        let presentingViewModel = StubPresentingViewModel<NSObject>()

                        let presenter = NSObject()
                        presentingViewModel.presenter = presenter

                        presentingViewModel.presentViewModel.apply(false).start()

                        expect(presentingViewModel.context.value).to(be(false))
                    }
                }
            }
        }

    }
}
