import UIKit
import Quick
import Nimble

@testable import Themer

class UILabelStyleSpec: QuickSpec {
    override func spec() {

        describe("UILabelStyle") {
            it("should update appropriate values") {
                let textColor: UIColor = .red
                let style = StubUILabelStyle(
                    textColor: textColor)
                let label = UILabel()

                expect(label.textColor).notTo(equal(textColor))

                style.apply(to: label)

                expect(label.textColor).to(equal(textColor))
            }
        }

    }
}
