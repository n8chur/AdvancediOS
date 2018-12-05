import UIKit
import Quick
import Nimble

@testable import Themer

class UITabBarStyleSpec: QuickSpec {
    override func spec() {

        describe("UITabBarStyle") {
            it("should update appropriate values") {
                let color: UIColor = .red
                let style = StubUITabBarStyle(color: color)
                let tabBar = UITabBar()

                expect(tabBar.backgroundColor).to(beNil())
                expect(tabBar.barTintColor).to(beNil())

                style.apply(to: tabBar)

                expect(tabBar.backgroundColor).to(equal(color))
                expect(tabBar.barTintColor).to(equal(color))
            }
        }

    }
}
