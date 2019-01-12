import Themer
import UIKit

public struct TabBarStyle: UITabBarStyle {

    public let barTintColor: UIColor?

    public init(theme: Theme) {
        barTintColor = theme.color.tabBarTint
    }

}
