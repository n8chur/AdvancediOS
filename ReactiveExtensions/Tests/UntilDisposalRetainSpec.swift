import Quick
import Nimble
import ReactiveSwift
import Result

@testable import ReactiveExtensions

class UntilDisposalRetainSpec: QuickSpec {
    override func spec() {

        describe("Signal.untilDisposal(retain:)") {
            it("should retain the object until the signal completes") {
                var retainedObject: NSObject? = NSObject()
                weak var weakObject = retainedObject

                var (signal, observer) = Signal<(), NoError>.pipe()
                signal = signal.untilDisposal(retain: retainedObject!)

                retainedObject = nil

                expect(weakObject).notTo(beNil())

                observer.sendCompleted()

                expect(weakObject).to(beNil())
            }
        }

        describe("SignalProducer.untilDisposal(retain:)") {
            it("should retain the object until the signal completes") {
                var retainedObject: NSObject? = NSObject()
                weak var weakObject = retainedObject

                let (signal, observer) = Signal<(), NoError>.pipe()
                let producer = SignalProducer(signal).untilDisposal(retain: retainedObject!)
                producer.start()

                retainedObject = nil

                expect(weakObject).notTo(beNil())

                observer.sendCompleted()

                expect(weakObject).to(beNil())
            }

            it("should not retain the object if the object is deallocated before start") {
                var retainedObject: NSObject? = NSObject()
                weak var weakObject = retainedObject

                let (signal, _) = Signal<(), NoError>.pipe()
                let producer = SignalProducer(signal).untilDisposal(retain: retainedObject!)

                retainedObject = nil

                producer.start()

                expect(weakObject).to(beNil())
            }
        }

    }
}
