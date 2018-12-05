import Themer
import UIKit

public struct LabelStyle: UILabelStyle {

    typealias View = UILabel

    public let textColor: UIColor
    public let backgroundColor: UIColor?

    public init(theme: Theme) {
        textColor = theme.color.bodyText
        backgroundColor = .clear
    }

}
