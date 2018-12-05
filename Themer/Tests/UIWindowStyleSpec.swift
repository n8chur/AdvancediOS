import UIKit
import Quick
import Nimble

@testable import Themer

class UIWindowStyleSpec: QuickSpec {
    override func spec() {

        describe("UIWindowStyle") {
            it("should update appropriate values") {
                let tintColor: UIColor = .green
                let style = StubUIWindowStyle(
                    tintColor: tintColor)
                let window = UIWindow()

                expect(window.tintColor).to(beNil())

                style.apply(to: window)

                expect(window.tintColor).to(equal(tintColor))
            }
        }

    }
}
