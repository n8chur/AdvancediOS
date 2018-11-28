import Quick
import Nimble
import ReactiveSwift
import Result

@testable import Core

class PresentationContextSpec: QuickSpec {
    override func spec() {

        describe("ResultPresentationContext") {
            context("when a value is sent along the dismiss signal") {
                context("after the present action has finished executing") {
                    it("should call the presentation's dismiss action") {
                        let viewModel = StubResultViewModel()
                        let stubPresentation = DismissablePresentation.stub()
                        let context = ResultPresentationContext(presentation: stubPresentation, viewModel: viewModel, presentAnimated: false, dismissAnimated: false)

                        let dismissDidExecute = MutableProperty(false)
                        dismissDidExecute <~ context.presentation.dismiss.isExecuting.signal
                            .filter { $0 }
                            .take(first: 1)

                        context.presentation.present.apply(false).start()

                        viewModel.resultObserver.send(value: true)

                        expect(dismissDidExecute.value).toEventually(beTrue())
                    }
                }

                context("before the present action has started execution") {
                    it("should call the presentation's dismiss action after presentation completes") {
                        let viewModel = StubResultViewModel()
                        let stubPresentation = DismissablePresentation.stub()
                        let context = ResultPresentationContext(presentation: stubPresentation, viewModel: viewModel, presentAnimated: false, dismissAnimated: false)

                        let dismissDidExecute = MutableProperty(false)
                        dismissDidExecute <~ context.presentation.dismiss.isExecuting.signal
                            .filter { $0 }
                            .take(first: 1)

                        viewModel.resultObserver.send(value: true)

                        context.presentation.present.apply(false).start()

                        expect(dismissDidExecute.value).toEventually(beTrue())
                    }
                }

            }
        }

    }
}
