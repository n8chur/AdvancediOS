import Themer
import UIKit

public struct WindowStyle: UIWindowStyle {

    typealias View = UIWindow

    public let tintColor: UIColor

    public init(theme: Theme) {
        tintColor = theme.color.actionColor
    }

}
