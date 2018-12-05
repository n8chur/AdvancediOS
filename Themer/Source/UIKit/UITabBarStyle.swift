import UIKit

public protocol UITabBarStyle: UIViewStyle where Styleable: UITabBar {
    var barTintColor: UIColor? { get }
}

public extension UITabBarStyle {
    public func apply(to styleable: UITabBar) {
        styleable.barTintColor = barTintColor

        apply(to: styleable as UIView)
    }
}
