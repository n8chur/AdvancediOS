import Themer
import UIKit

struct TabBarStyle: UITabBarStyle {

    typealias View = UILabel

    let barTintColor: UIColor?
    let backgroundColor: UIColor?

    init(theme: Theme) {
        switch theme {
        case .light:
            barTintColor = ColorType.Light.tabBarTint
        case .dark:
            barTintColor = ColorType.Dark.tabBarTint
        }

        backgroundColor = nil
    }

}
