import UIKit

public protocol UILabelStyle: Style where Styleable: UILabel {
    var textColor: UIColor { get }
    var textAlignment: NSTextAlignment { get }
    var numberOfLines: Int { get }
}

public extension UILabelStyle {

    public func apply(to styleable: UILabel) {
        styleable.textColor = textColor
        styleable.textAlignment = textAlignment
        styleable.numberOfLines = numberOfLines
    }

}
