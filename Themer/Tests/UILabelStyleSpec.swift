import UIKit
import Quick
import Nimble

@testable import Themer

class UILabelStyleSpec: QuickSpec {
    override func spec() {

        describe("UILabelStyle") {
            it("should update appropriate values") {
                let color: UIColor = .red
                let style = StubUILabelStyle(color: color)
                let label = UILabel()

                expect(label.textColor).notTo(equal(color))
                expect(label.backgroundColor).notTo(equal(color))

                style.apply(to: label)

                expect(label.textColor).to(equal(color))
                expect(label.backgroundColor).to(equal(color))
            }
        }

    }
}
