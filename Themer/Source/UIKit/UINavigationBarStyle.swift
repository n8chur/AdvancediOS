import UIKit

public protocol UINavigationBarStyle: Style where Styleable: UINavigationBar {
    var barTintColor: UIColor? { get }
}

public extension UINavigationBarStyle {
    public func apply(to styleable: UINavigationBar) {
        styleable.barTintColor = barTintColor
    }
}
