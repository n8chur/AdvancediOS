import UIKit

public protocol UIViewStyle: Style where Styleable: UIView {
    var backgroundColor: UIColor? { get }
}

public extension UIViewStyle {
    public func apply(to view: UIView) {
        view.backgroundColor = backgroundColor
    }
}
