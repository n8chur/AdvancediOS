import UIKit

public protocol UIWindowStyle: Style where Styleable: UIWindow {
    var tintColor: UIColor { get }
}

public extension UIWindowStyle {
    public func apply(to styleable: UIWindow) {
        styleable.tintColor = tintColor
    }
}
