import Themer
import UIKit

struct NavigationBarStyle: UINavigationBarStyle {

    typealias View = UILabel

    let barTintColor: UIColor?
    let backgroundColor: UIColor?

    init(theme: Theme) {
        switch theme {
        case .light:
            barTintColor = ColorType.Light.navigationBarTint
        case .dark:
            barTintColor = ColorType.Dark.navigationBarTint
        }

        backgroundColor = nil
    }

}
