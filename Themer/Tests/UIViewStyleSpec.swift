import UIKit
import Quick
import Nimble

@testable import Themer

class UIViewStyleSpec: QuickSpec {
    override func spec() {

        describe("UIViewStyle") {
            it("should update appropriate values") {
                let color: UIColor = .red
                let style = StubUIViewStyle(color: color)
                let view = UIView()

                expect(view.backgroundColor).to(beNil())

                style.apply(to: view)

                expect(view.backgroundColor).to(equal(color))
            }
        }

    }
}
