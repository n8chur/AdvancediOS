import UIKit

public protocol UIViewStyle: Style where Styleable: UIView {
    var backgroundColor: UIColor? { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var borderColor: UIColor? { get }
}

public extension UIViewStyle {
    public func apply(to styleable: UIView) {
        styleable.backgroundColor = backgroundColor
        styleable.layer.cornerRadius = cornerRadius
        styleable.layer.borderWidth = borderWidth
        styleable.layer.borderColor = borderColor?.cgColor
    }
}
