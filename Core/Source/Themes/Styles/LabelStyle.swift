import Themer
import UIKit

public struct LabelStyle: UILabelStyle {

    typealias View = UILabel

    public let textColor: UIColor

    public init(theme: Theme) {
        textColor = theme.color.bodyText
    }

}
