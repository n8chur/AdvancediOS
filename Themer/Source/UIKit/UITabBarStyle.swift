import UIKit

public protocol UITabBarStyle: Style where Styleable: UITabBar {
    var barTintColor: UIColor? { get }
}

public extension UITabBarStyle {
    public func apply(to styleable: UITabBar) {
        styleable.barTintColor = barTintColor
    }
}
