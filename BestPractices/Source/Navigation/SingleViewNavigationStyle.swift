import Themer
import UIKit
import Core

struct SingleViewNavigationStyle: Style {
    typealias Styleable = SingleViewNavigationController

    let navigationBar: NavigationBarStyle
    let theme: Theme

    init(theme: Theme) {
        self.theme = theme
        navigationBar = NavigationBarStyle(theme: theme)
    }

    func apply(to styleable: SingleViewNavigationController) {
        navigationBar.apply(to: styleable.navigationBar)
        styleable.statusBarStyle = theme.statusBarStyle
        styleable.setNeedsStatusBarAppearanceUpdate()
    }

}
