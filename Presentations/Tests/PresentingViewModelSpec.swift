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

                        expect(presentingViewModel.getPresenter.value).to(be(presenter))
                        expect(presentingViewModel.getViewModel).notTo(beNil())

                        guard let (getViewModelPresenter, getViewModelViewModel) = presentingViewModel.getViewModel.value else {
                            fail("Failed to get values from getViewModel.")
                            return
                        }

                        expect(getViewModelPresenter).to(equal(presenter))

                        guard let (getPresentationPresenter, getPresentationViewModel, getPresentationPresentation) = presentingViewModel.getPresentation.value else {
                            fail("Failed to get values from getPresentation.")
                            return
                        }

                        expect(getPresentationPresenter).to(be(presenter))
                        expect(getPresentationViewModel).to(be(getViewModelViewModel))

                        guard let (getContextPresentation, getContextViewModel, getContextAnimated) = presentingViewModel.getContext.value else {
                            fail("Failed to get values from getContext.")
                            return
                        }

                        expect(getContextPresentation).to(be(getPresentationPresentation))
                        expect(getContextViewModel).to(be(getPresentationViewModel))
                        expect(getContextAnimated).to(be(false))
                    }

                    it("should propogate the appropriate value for animated") {
                        let presentingViewModel = StubPresentingViewModel<NSObject>()

                        let presenter = NSObject()
                        presentingViewModel.presenter = presenter

                        presentingViewModel.presentViewModel.apply(true).start()

                        guard let (_, _, animated) = presentingViewModel.getContext.value else {
                            fail("Failed to get values from getContext.")
                            return
                        }

                        expect(animated).to(be(true))
                    }
                }
            }
        }

    }
}
