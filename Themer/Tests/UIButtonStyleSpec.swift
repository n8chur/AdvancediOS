import UIKit
import Quick
import Nimble

@testable import Themer

class UIButtonStyleSpec: QuickSpec {
    override func spec() {

        describe("UIButtonStyle") {
            it("should update appropriate values") {
                let titleColor: UIColor = .red
                let backgroundColor: UIColor = .green
                let borderColor: UIColor = .blue
                let cornerRadius: CGFloat = 20
                let borderWidth: CGFloat = 30
                let contentEdgeInsets = UIEdgeInsets(top: 99, left: 99, bottom: 99, right: 99)
                let style = StubUIButtonStyle(
                    titleColor: titleColor,
                    contentEdgeInsets: contentEdgeInsets,
                    backgroundColor: backgroundColor,
                    cornerRadius: cornerRadius,
                    borderWidth: borderWidth,
                    borderColor: borderColor)
                let button = UIButton()

                guard let initialTitleColor = button.titleColor(for: .normal) else {
                    fail("titleColor was initially nil.")
                    return
                }

                expect(initialTitleColor).notTo(equal(titleColor))
                expect(button.backgroundColor).to(beNil())
                expect(button.contentEdgeInsets).notTo(equal(contentEdgeInsets))
                expect(button.layer.borderColor).notTo(equal(borderColor.cgColor))
                expect(button.layer.cornerRadius).notTo(equal(cornerRadius))
                expect(button.layer.borderWidth).notTo(equal(borderWidth))

                style.apply(to: button)

                guard let titleColorResult = button.titleColor(for: .normal) else {
                    fail("titleColor was nil.")
                    return
                }

                expect(titleColorResult).to(equal(titleColor))
                expect(button.backgroundColor).to(equal(backgroundColor))
                expect(button.contentEdgeInsets).to(equal(contentEdgeInsets))
                expect(button.layer.borderColor).to(equal(borderColor.cgColor))
                expect(button.layer.cornerRadius).to(equal(cornerRadius))
                expect(button.layer.borderWidth).to(equal(borderWidth))
            }
        }

    }
}
