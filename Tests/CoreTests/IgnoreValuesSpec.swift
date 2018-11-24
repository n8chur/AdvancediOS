import Quick
import Nimble
import ReactiveSwift
import Result

@testable import Core

class IgnoreValuesSpec: QuickSpec {
    override func spec() {

        describe("Signal.ignoreValues()") {
            it("should ignore all values") {
                let (valuesSignal, observer) = Signal<Bool, NoError>.pipe()

                let signal = valuesSignal.ignoreValues()

                var valueCount = 0
                signal.observeValues { in
                    valueCount += 1
                }

                var completed = false
                signal.observeCompleted {
                    completed = true
                }

                observer.send(value: true)
                observer.sendCompleted()

                expect(valueCount).to(be(0))
                expect(completed).to(beTrue())
            }
        }

        describe("SignalProducer.ignoreValues()") {
            it("should ignore all values") {
                let (signal, observer) = Signal<Bool, NoError>.pipe()
                let producer = signal.producer.ignoreValues()

                var valueCount = 0
                var completed = false

                producer
                    .on(completed: { completed = true },
                        value: { valueCount += 1 })
                    .start()

                observer.send(value: true)
                observer.sendCompleted()

                expect(valueCount).to(be(0))
                expect(completed).to(beTrue())

            }
        }

    }
}
