import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import RxExtensions

class PropertySpec: QuickSpec {
    override func spec() {

        describe("Property.bind(to:)") {
            it("should bind values sent into the observable it's initialized with") {
                let propertyRelay = BehaviorRelay<String?>(value: nil)
                let property = Property<String?>(propertyRelay.asObservable(), initial: nil)
                let resultRelay = BehaviorRelay<String?>(value: nil)

                _ = property.bind(to: resultRelay)

                propertyRelay.accept("foo")

                expect(resultRelay.value).to(equal("foo"))
            }
        }

    }
}
