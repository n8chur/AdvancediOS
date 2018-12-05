import Themer
import UIKit
import Core

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
        styleable.statusBarStyle = theme.statusBarStyle
        styleable.setNeedsStatusBarAppearanceUpdate()
    }

}
