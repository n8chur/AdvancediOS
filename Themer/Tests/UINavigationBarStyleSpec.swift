import UIKit
import Quick
import Nimble

@testable import Themer

class UINavigationBarStyleSpec: QuickSpec {
    override func spec() {

        describe("UINavigationBarStyle") {
            it("should update appropriate values") {
                let color: UIColor = .red
                let style = StubUINavigationBarStyle(
                    barTintColor: color)
                let navigationBar = UINavigationBar()

                expect(navigationBar.barTintColor).to(beNil())

                style.apply(to: navigationBar)

                expect(navigationBar.barTintColor).to(equal(color))
            }
        }

    }
}
