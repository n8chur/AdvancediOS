import UIKit

public protocol UIButtonStyle: UIViewStyle where Styleable: UIButton {
    var titleColor: UIColor? { get }
    var contentEdgeInsets: UIEdgeInsets { get }
}

public extension UIButtonStyle {
    func apply(to styleable: UIButton) {
        styleable.setTitleColor(titleColor, for: .normal)
        styleable.contentEdgeInsets = contentEdgeInsets

        apply(to: styleable as UIView)
    }
}
