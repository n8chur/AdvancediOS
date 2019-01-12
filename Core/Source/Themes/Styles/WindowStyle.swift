import Themer
import UIKit

public struct WindowStyle: UIWindowStyle {

    public let tintColor: UIColor

    public init(theme: Theme) {
        tintColor = theme.color.actionColor
    }

}
