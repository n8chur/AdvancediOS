import Themer
import UIKit
import Core

struct TabBarChildNavigationStyle<ViewModelType: TabBarChildViewModel>: Style {
    typealias Styleable = TabBarChildNavigationController<ViewModelType>

    let navigationBar: NavigationBarStyle
    let theme: Theme

    init(theme: Theme) {
        self.theme = theme
        navigationBar = NavigationBarStyle(theme: theme)
    }

    func apply(to styleable: Styleable) {
        navigationBar.apply(to: styleable.navigationBar)
        styleable.statusBarStyle = theme.statusBarStyle
        styleable.setNeedsStatusBarAppearanceUpdate()
    }

}
