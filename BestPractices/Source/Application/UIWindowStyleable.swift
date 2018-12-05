import UIKit
import Core
import Themer

extension UIWindow: StyleApplicable {

    public typealias StyleType = WindowStyle
    public typealias ThemeType = Theme

    public func makeStyleWithTheme(_ theme: Theme) -> WindowStyle {
        return WindowStyle(theme: theme)
    }

}
