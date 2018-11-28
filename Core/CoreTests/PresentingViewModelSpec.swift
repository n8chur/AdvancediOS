import Quick
import Nimble
import ReactiveSwift
import Result

@testable import Core

class PresentatingViewModelSpec: QuickSpec {
    override func spec() {

        describe("PresentingViewModel") {
            describe("makePresent(...)") {
                context("when the presenter is set") {
                    it("should call all of the appropriate callback functions") {
                        let presentingViewModel = StubPresentingViewModel<NSObject>()

                        let presenter = NSObject()
                        presentingViewModel.presenter = presenter

                        presentingViewModel.presentViewModel.apply().start()

                        expect(presentingViewModel.getPresenter.value).to(be(presenter))
                        expect(presentingViewModel.getViewModel).notTo(beNil())

                        guard let (getViewModelPresenter, getViewModelViewModel) = presentingViewModel.getViewModel.value else {
                            fail("Failed to get values from getViewModel.")
                            return
                        }

                        expect(getViewModelPresenter).to(equal(presenter))
                        expect(presentingViewModel.setupViewModel.value).to(be(getViewModelViewModel))

                        guard let (getPresentationProducerPresenter, getPresentationProducerViewModel) = presentingViewModel.getPresentationProducer.value else {
                            fail("Failed to get values from getPresentationProducer.")
                            return
                        }

                        expect(getPresentationProducerPresenter).to(be(presenter))
                        expect(getPresentationProducerViewModel).to(be(getViewModelViewModel))
                    }
                }
            }
        }

    }
}
