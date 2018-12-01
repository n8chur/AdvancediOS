import Quick
import Nimble
import ReactiveSwift
import Result

@testable import Presentations

class PresenterSpec: QuickSpec {
    override func spec() {

        describe("Presenter") {
            describe("makePresention(...)") {
                it("should return a signal that call the appropriate closues") {
                    let presenter = StubPresenter()
                    let viewModel = StubViewModel()
                    let context = DismissablePresentationContext.stub()
                    let producer = presenter.makePresentation(of: viewModel, context: context)

                    producer.start()

                    expect(presenter.setupPresenters.value).to(be(viewModel))
                    expect(presenter.getContext.value).to(be(viewModel))
                }

                it("should execute the present action") {
                    let presenter = StubPresenter()
                    let viewModel = StubViewModel()
                    let context = DismissablePresentationContext.stub()
                    let producer = presenter.makePresentation(of: viewModel, context: context)

                    let hasExectutedPresent = MutableProperty(false)
                    hasExectutedPresent <~ context.presentation.present.isExecuting.signal
                        .filter { $0 }
                        .take(first: 1)

                    producer.start()

                    expect(hasExectutedPresent.value).to(beTrue())
                }
            }
        }

    }
}
