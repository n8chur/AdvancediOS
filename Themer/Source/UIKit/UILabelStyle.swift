import UIKit

public protocol UILabelStyle: UIViewStyle where Styleable: UILabel {
    var textColor: UIColor { get }
}

public extension UILabelStyle {
    public func apply(to styleable: UILabel) {
        styleable.textColor = textColor

        apply(to: styleable as UIView)
    }
}
