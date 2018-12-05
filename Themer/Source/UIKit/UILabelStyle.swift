import UIKit

public protocol UILabelStyle: Style where Styleable: UILabel {
    var textColor: UIColor { get }
}

public extension UILabelStyle {
    public func apply(to styleable: UILabel) {
        styleable.textColor = textColor
    }
}
