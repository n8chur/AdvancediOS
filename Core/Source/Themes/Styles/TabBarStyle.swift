import Themer
import UIKit

public struct TabBarStyle: UITabBarStyle {

    typealias View = UILabel

    public let barTintColor: UIColor?
    public let backgroundColor: UIColor?

    public init(theme: Theme) {
        barTintColor = theme.color.tabBarTint
        backgroundColor = nil
    }

}
