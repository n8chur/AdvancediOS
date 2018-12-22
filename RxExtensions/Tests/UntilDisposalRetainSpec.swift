import Quick
import Nimble
import RxSwift
import RxTest

@testable import RxExtensions

class UntilDisposalRetainSpec: QuickSpec {
    override func spec() {

        describe("ObservableType.untilDisposal(retain:)") {
            it("should retain the object until the signal completes") {
                var retainedObject: NSObject? = NSObject()
                weak var weakObject = retainedObject

                let subject = PublishSubject<String>()

                let observable = subject.untilDisposal(retain: retainedObject!)

                let disposable = observable.subscribe()

                retainedObject = nil

                expect(weakObject).notTo(beNil())

                subject.onCompleted()

                expect(weakObject).to(beNil())

                disposable.dispose()
            }

            it("should not retain the object if the object is deallocated before start") {
                var retainedObject: NSObject? = NSObject()
                weak var weakObject = retainedObject

                let subject = PublishSubject<String>()

                let observable = subject.untilDisposal(retain: retainedObject!)

                retainedObject = nil

                _ = observable.subscribe()

                expect(weakObject).to(beNil())
            }
        }

    }
}
