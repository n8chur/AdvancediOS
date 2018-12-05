import Themer
import UIKit

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

        switch theme {
        case .light:
            styleable.statusBarStyle = .default
        case .dark:
            styleable.statusBarStyle = .lightContent
        }

        styleable.setNeedsStatusBarAppearanceUpdate()
    }

}

extension SingleViewNavigationController: StyleApplicable {

    typealias StyleType = SingleViewNavigationStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> SingleViewNavigationStyle {
        return SingleViewNavigationStyle(theme: theme)
    }

}
