import Themer
import UIKit

struct TabBarChildNavigationStyle: Style {
    typealias Styleable = TabBarChildNavigationController

    let navigationBar: NavigationBarStyle

    init(theme: Theme) {
        navigationBar = NavigationBarStyle(theme: theme)
    }

    func apply(to styleable: TabBarChildNavigationController) {
        navigationBar.apply(to: styleable.navigationBar)
    }

}

extension TabBarChildNavigationController: StyleApplicable {

    typealias StyleType = TabBarChildNavigationStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> TabBarChildNavigationStyle {
        return TabBarChildNavigationStyle(theme: theme)
    }

}
