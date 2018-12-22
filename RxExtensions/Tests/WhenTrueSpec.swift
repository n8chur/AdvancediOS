import Quick
import Nimble
import RxSwift
import RxBlocking

@testable import RxExtensions

class WhenTrueSpec: QuickSpec {
    override func spec() {

        describe("ObservableType.whenTrue(subscribeTo:otherwise:)") {
            let expectedTrueValue = 1
            var trueExecutions = 0
            let trueObservable = Observable<Int>.create { observer in
                observer.onNext(expectedTrueValue)
                trueExecutions += 1
                observer.onCompleted()
                return SerialDisposable()
            }
            let expectedFalseValue = 0
            var falseExecutions = 0
            let falseObservable = Observable<Int>.create { observer in
                observer.onNext(expectedFalseValue)
                falseExecutions += 1
                observer.onCompleted()
                return SerialDisposable()
            }

            beforeEach {
                trueExecutions = 0
                falseExecutions = 0
            }

            it("only subscribes to true observable if true is sent") {
                let boolObservable = Observable.from([true])

                let whenTrue = boolObservable.whenTrue(subscribeTo: trueObservable, otherwise: falseObservable)
                let value = try? whenTrue.toBlocking().first()

                expect(value).to(equal(expectedTrueValue))

                expect(trueExecutions).to(equal(1))
                expect(falseExecutions).to(equal(0))
            }

            it("only subscribes to false observable if false is sent") {
                let boolObservable = Observable.from([false])

                let whenTrue = boolObservable.whenTrue(subscribeTo: trueObservable, otherwise: falseObservable)
                let value = try? whenTrue.toBlocking().first()

                expect(value).to(equal(expectedFalseValue))

                expect(trueExecutions).to(equal(0))
                expect(falseExecutions).to(equal(1))
            }
        }

    }
}
