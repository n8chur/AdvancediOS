import UIKit
import Quick
import Nimble

@testable import Themer

class UILabelStyleSpec: QuickSpec {
    override func spec() {

        describe("UILabelStyle") {
            it("should update appropriate values") {
                let textColor: UIColor = .red
                let textAlignment: NSTextAlignment = .right
                let numberOfLines = 99
                let style = StubUILabelStyle(
                    textColor: textColor,
                    textAlignment: textAlignment,
                    numberOfLines: numberOfLines)
                let label = UILabel()

                expect(label.textColor).notTo(equal(textColor))
                expect(label.textAlignment).notTo(equal(textAlignment))
                expect(label.numberOfLines).notTo(equal(numberOfLines))

                style.apply(to: label)

                expect(label.textColor).to(equal(textColor))
                expect(label.textAlignment).to(equal(textAlignment))
                expect(label.numberOfLines).to(equal(numberOfLines))
            }
        }

    }
}
