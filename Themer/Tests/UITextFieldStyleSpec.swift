import UIKit
import Quick
import Nimble

@testable import Themer

class UITextFieldStyleSpec: QuickSpec {
    override func spec() {

        describe("UITextFieldStyle") {
            it("should update appropriate values") {
                let color: UIColor = .red
                let style = StubUITextFieldStyle(color: color)
                let textField = UITextField()

                expect(textField.textColor).notTo(equal(color))
                expect(textField.backgroundColor).to(beNil())

                style.apply(to: textField)

                expect(textField.textColor).to(equal(color))
                expect(textField.backgroundColor).to(equal(color))
            }
        }

    }
}
