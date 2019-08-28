import UIKit

public protocol UIWindowStyle: Style where Styleable: UIWindow {
    var tintColor: UIColor { get }
}

public extension UIWindowStyle {
    func apply(to styleable: UIWindow) {
        styleable.tintColor = tintColor
    }
}
