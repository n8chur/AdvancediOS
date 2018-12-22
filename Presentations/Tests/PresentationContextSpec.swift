import Quick
import Nimble
import RxSwift
import Action

@testable import Presentations

class PresentationContextSpec: QuickSpec {
    override func spec() {

        describe("ResultPresentationContext") {
            context("when a value is sent along the dismiss signal") {
                context("after the present action has finished executing") {
                    it("should call the presentation's dismiss action") {
                        let viewModel = StubResultViewModel()
                        let stubPresentation = DismissablePresentation.stub()
                        let context = ResultPresentationContext(presentation: stubPresentation, viewModel: viewModel, presentAnimated: false, dismissAnimated: false)

                        let dismissDidExecute = Variable(false)
                        _ = context.presentation.dismiss.completed
                            .map { true }
                            .bind(to: dismissDidExecute)

                        _ = context.presentation.present.execute(false).subscribe()

                        viewModel.resultSubject.onNext(())

                        expect(dismissDidExecute.value).toEventually(beTrue())
                    }
                }

                context("before the present action has started execution") {
                    it("should call the presentation's dismiss action after presentation completes") {
                        let viewModel = StubResultViewModel()
                        let stubPresentation = DismissablePresentation.stub()
                        let context = ResultPresentationContext(presentation: stubPresentation, viewModel: viewModel, presentAnimated: false, dismissAnimated: false)

                        let dismissDidExecute = Variable(false)
                        _ = context.presentation.dismiss.completed
                            .map { true }
                            .bind(to: dismissDidExecute)

                        viewModel.resultSubject.onNext(())

                        _ = context.presentation.present.execute(false).subscribe()

                        expect(dismissDidExecute.value).toEventually(beTrue())
                    }
                }

            }
        }

    }
}
