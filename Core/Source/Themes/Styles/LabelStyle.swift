import Themer
import UIKit

public struct LabelStyle: UILabelStyle {

    public let textColor: UIColor

    public init(theme: Theme) {
        textColor = theme.color.bodyText
    }

}
