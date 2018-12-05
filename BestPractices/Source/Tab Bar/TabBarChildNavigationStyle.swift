import Themer
import UIKit

struct TabBarChildNavigationStyle: Style {
    typealias Styleable = TabBarChildNavigationController

    let background: BackgroundViewStyle
    let navigationBar: NavigationBarStyle

    init(theme: Theme) {
        background = BackgroundViewStyle(theme: theme)
        navigationBar = NavigationBarStyle(theme: theme)
    }

    func apply(to styleable: TabBarChildNavigationController) {
        background.apply(to: styleable.view)
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
