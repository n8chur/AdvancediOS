import Themer
import UIKit

public struct LabelStyle: UILabelStyle {

    public let textColor: UIColor
    public let numberOfLines: Int = 0
    public let textAlignment: NSTextAlignment = .center

    public init(theme: Theme) {
        textColor = theme.color.bodyText
    }

}

public struct AlternateLabelStyle: UILabelStyle {

    public let textColor: UIColor
    public let numberOfLines: Int = 0
    public let textAlignment: NSTextAlignment = .center

    public init(theme: Theme) {
        textColor = theme.color.alternateBodyText
    }

}
