import Themer
import UIKit

struct TabBarChildNavigationStyle: Style {
    typealias Styleable = TabBarChildNavigationController

    let navigationBar: NavigationBarStyle
    let theme: Theme

    init(theme: Theme) {
        self.theme = theme
        navigationBar = NavigationBarStyle(theme: theme)
    }

    func apply(to styleable: TabBarChildNavigationController) {
        navigationBar.apply(to: styleable.navigationBar)

        switch theme {
        case .light:
            styleable.statusBarStyle = .default
        case .dark:
            styleable.statusBarStyle = .lightContent
        }

        styleable.setNeedsStatusBarAppearanceUpdate()
    }

}

extension TabBarChildNavigationController: StyleApplicable {

    typealias StyleType = TabBarChildNavigationStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> TabBarChildNavigationStyle {
        return TabBarChildNavigationStyle(theme: theme)
    }

}
