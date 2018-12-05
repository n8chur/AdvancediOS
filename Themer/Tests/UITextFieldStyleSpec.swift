import UIKit
import Quick
import Nimble

@testable import Themer

class UITextFieldStyleSpec: QuickSpec {
    override func spec() {

        describe("UITextFieldStyle") {
            it("should update appropriate values") {
                let textColor: UIColor = .red
                let style = StubUITextFieldStyle(
                    textColor: textColor)
                let textField = UITextField()

                expect(textField.textColor).notTo(equal(textColor))

                style.apply(to: textField)

                expect(textField.textColor).to(equal(textColor))
            }
        }

    }
}
