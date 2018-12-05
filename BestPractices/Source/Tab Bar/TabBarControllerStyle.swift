import Themer
import UIKit
import Core

struct TabBarControllerStyle: Style {
    typealias Styleable = TabBarController

    let tabBar: TabBarStyle

    init(theme: Theme) {
        tabBar = TabBarStyle(theme: theme)
    }

    func apply(to styleable: TabBarController) {
        tabBar.apply(to: styleable.tabBar)
    }

}

extension TabBarController: StyleApplicable {

    typealias StyleType = TabBarControllerStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> TabBarControllerStyle {
        return TabBarControllerStyle(theme: theme)
    }

}
