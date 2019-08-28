import UIKit

public protocol UITabBarStyle: Style where Styleable: UITabBar {
    var barTintColor: UIColor? { get }
}

public extension UITabBarStyle {
    func apply(to styleable: UITabBar) {
        styleable.barTintColor = barTintColor
    }
}
