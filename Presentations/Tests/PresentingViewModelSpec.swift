import Quick
import Nimble
import RxSwift

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

                        _ = presentingViewModel.presentViewModel.execute(false).subscribe()

                        expect(presentingViewModel.context.value).to(be(false))
                    }
                }
            }
        }

    }
}
