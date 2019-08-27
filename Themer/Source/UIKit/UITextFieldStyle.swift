import UIKit

public protocol UITextFieldStyle: Style where Styleable: UITextField {
    var textColor: UIColor { get }
}

public extension UITextFieldStyle {
    func apply(to styleable: UITextField) {
        styleable.textColor = textColor
    }
}
