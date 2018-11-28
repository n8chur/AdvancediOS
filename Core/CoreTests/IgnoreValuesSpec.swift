import Quick
import Nimble
import ReactiveSwift
import Result

@testable import Core

class IgnoreValuesSpec: QuickSpec {
    override func spec() {

        describe("Signal.ignoreValues()") {
            it("should should ignore all values and eventually complete") {
                let (valuesSignal, observer) = Signal<Bool, NoError>.pipe()

                let signal = valuesSignal.ignoreValues()

                var completed = false
                signal.observeCompleted {
                    completed = true
                }

                observer.send(value: true)
                observer.sendCompleted()

                expect(completed).to(beTrue())
            }
        }

        describe("SignalProducer.ignoreValues()") {
            it("should ignore all values and eventually complete") {
                let (signal, observer) = Signal<Bool, NoError>.pipe()
                let producer = signal.producer.ignoreValues()

                var completed = false

                producer
                    .on(completed: { completed = true })
                    .start()

                observer.send(value: true)
                observer.sendCompleted()

                expect(completed).to(beTrue())

            }
        }

    }
}
