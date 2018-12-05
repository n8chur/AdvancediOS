import UIKit
import Quick
import Nimble

@testable import Themer

class UIViewStyleSpec: QuickSpec {
    override func spec() {

        describe("UIViewStyle") {
            it("should update appropriate values") {
                let backgroundColor: UIColor = .green
                let borderColor: UIColor = .blue
                let cornerRadius: CGFloat = 20
                let borderWidth: CGFloat = 30
                let style = StubUIViewStyle(
                    backgroundColor: backgroundColor,
                    cornerRadius: cornerRadius,
                    borderWidth: borderWidth,
                    borderColor: borderColor)
                let view = UIView()

                expect(view.backgroundColor).to(beNil())
                expect(view.layer.borderColor).notTo(equal(borderColor.cgColor))
                expect(view.layer.cornerRadius).notTo(equal(cornerRadius))
                expect(view.layer.borderWidth).notTo(equal(borderWidth))

                style.apply(to: view)

                expect(view.backgroundColor).to(equal(backgroundColor))
                expect(view.layer.borderColor).to(equal(borderColor.cgColor))
                expect(view.layer.cornerRadius).to(equal(cornerRadius))
                expect(view.layer.borderWidth).to(equal(borderWidth))
            }
        }

    }
}
