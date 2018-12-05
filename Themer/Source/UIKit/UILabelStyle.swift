import UIKit

public protocol UILabelStyle: UIViewStyle where View: UILabel {
    var textColor: UIColor { get }
}

public extension UILabelStyle {
    public func apply(to view: UILabel) {
        view.textColor = textColor

        apply(to: view as UIView)
    }
}
