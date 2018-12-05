import UIKit
import Quick
import Nimble

@testable import Themer

class UITabBarStyleSpec: QuickSpec {
    override func spec() {

        describe("UITabBarStyle") {
            it("should update appropriate values") {
                let color: UIColor = .red
                let style = StubUITabBarStyle(
                    barTintColor: color)
                let tabBar = UITabBar()

                expect(tabBar.barTintColor).to(beNil())

                style.apply(to: tabBar)

                expect(tabBar.barTintColor).to(equal(color))
            }
        }

    }
}
