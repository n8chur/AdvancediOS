import Themer
import UIKit

public struct NavigationBarStyle: UINavigationBarStyle {

    public let barTintColor: UIColor?

    public init(theme: Theme) {
        barTintColor = theme.color.navigationBarTint
    }

}
