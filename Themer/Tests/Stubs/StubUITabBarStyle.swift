import Themer
import UIKit

struct StubUITabBarStyle: UITabBarStyle {

    typealias View = UITabBar

    let barTintColor: UIColor?
    let backgroundColor: UIColor?

    init(color: UIColor) {
        barTintColor = color
        backgroundColor = color
    }

}
