import UIKit

public protocol UITextFieldStyle: UIViewStyle where Styleable: UITextField {
    var textColor: UIColor { get }
}

public extension UITextFieldStyle {
    public func apply(to styleable: UITextField) {
        styleable.textColor = textColor

        apply(to: styleable as UIView)
    }
}
