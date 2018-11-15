import Quick
import Nimble
import ReactiveSwift
import Result

@testable import Core

class SignalProducerWhenTrueSpec: QuickSpec {
    override func spec() {

        describe("SignalProducer.whenTrue(subscribeTo:,otherwise:)") {

            let expectedTrueValue = 1
            var trueExecutions = 0
            let trueProducer = SignalProducer<Int, NoError> { (observer, _) in
                observer.send(value: expectedTrueValue)
                trueExecutions += 1
                observer.sendCompleted()
            }
            let expectedFalseValue = 0
            var falseExecutions = 0
            let falseProducer = SignalProducer<Int, NoError> { (observer, _) in
                observer.send(value: expectedFalseValue)
                falseExecutions += 1
                observer.sendCompleted()
            }

            beforeEach {
                trueExecutions = 0
                falseExecutions = 0
            }

            it("only subscribes to true producer if true is sent") {
                let boolProducer = SignalProducer(value: true)

                var value: Int?
                boolProducer
                    .whenTrue(subscribeTo: trueProducer, otherwise: falseProducer)
                    .on(value: { value = $0 })
                    .start()

                expect(value).to(equal(expectedTrueValue))

                expect(trueExecutions).to(equal(1))
                expect(falseExecutions).to(equal(0))
            }

            it("only subscribes to false producer if false is sent") {
                let boolProducer = SignalProducer(value: false)

                var value: Int?
                boolProducer
                    .whenTrue(subscribeTo: trueProducer, otherwise: falseProducer)
                    .on(value: { value = $0 })
                    .start()

                expect(value).to(equal(expectedFalseValue))

                expect(trueExecutions).to(equal(0))
                expect(falseExecutions).to(equal(1))
            }
        }

    }
}
