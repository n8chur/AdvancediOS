import Quick
import Nimble
import RxSwift
import Action

@testable import RxExtensions

class ActionCompletedSpec: QuickSpec {
    override func spec() {

        describe("Action.completed") {
            it("should send () when the execution signal completes") {
                let action = CompletableAction { Completable.empty() }

                var completedCount = 0

                _ = action.completed.subscribe(onNext: { _ in
                    completedCount += 1
                })

                expect(completedCount).to(equal(0))

                action.execute(())

                expect(completedCount).to(equal(1))

                action.execute(())

                expect(completedCount).to(equal(2))
            }
        }

    }
}
