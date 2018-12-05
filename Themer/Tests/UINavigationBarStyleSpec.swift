import UIKit
import Quick
import Nimble

@testable import Themer

class UINavigationBarStyleSpec: QuickSpec {
    override func spec() {

        describe("UINavigationBarStyle") {
            it("should update appropriate values") {
                let color: UIColor = .red
                let style = StubUINavigationBarStyle(color: color)
                let navigationBar = UINavigationBar()

                expect(navigationBar.backgroundColor).to(beNil())
                expect(navigationBar.barTintColor).to(beNil())

                style.apply(to: navigationBar)

                expect(navigationBar.backgroundColor).to(equal(color))
                expect(navigationBar.barTintColor).to(equal(color))
            }
        }

    }
}
