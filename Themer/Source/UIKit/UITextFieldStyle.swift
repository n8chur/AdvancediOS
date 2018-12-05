import UIKit

public protocol UITextFieldStyle: UIViewStyle where Styleable: UITextField {
    var textColor: UIColor { get }
}

public extension UITextFieldStyle {
    public func apply(to view: UITextField) {
        view.textColor = textColor

        apply(to: view as UIView)
    }
}
