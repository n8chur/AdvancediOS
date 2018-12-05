import Themer
import UIKit

public struct NavigationBarStyle: UINavigationBarStyle {

    typealias View = UILabel

    public let barTintColor: UIColor?

    public init(theme: Theme) {
        barTintColor = theme.color.navigationBarTint
    }

}
