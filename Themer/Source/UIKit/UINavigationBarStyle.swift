import UIKit

public protocol UINavigationBarStyle: UIViewStyle where Styleable: UINavigationBar {
    var barTintColor: UIColor? { get }
}

public extension UINavigationBarStyle {
    public func apply(to styleable: UINavigationBar) {
        styleable.barTintColor = barTintColor

        apply(to: styleable as UIView)
    }
}
