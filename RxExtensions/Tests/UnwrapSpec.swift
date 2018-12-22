import Quick
import Nimble
import RxSwift
import RxBlocking

@testable import RxExtensions

class UnwrapSpec: QuickSpec {
    override func spec() {

        describe("ObservableType.unwrap()") {
            it("should filter out nil values") {
                let observable = Observable<String?>.from([
                    nil,
                    "foo",
                    nil,
                    "bar",
                ])

                let unwrappedObservable = observable.unwrap()

                let unwrapped = try? unwrappedObservable.toBlocking().toArray()
                expect(unwrapped).to(equal(["foo", "bar"]))
            }
        }

    }
}
