import Themer
import UIKit

struct SingleViewNavigationStyle: Style {
    typealias Styleable = SingleViewNavigationController

    let navigationBar: NavigationBarStyle

    init(theme: Theme) {
        navigationBar = NavigationBarStyle(theme: theme)
    }

    func apply(to styleable: SingleViewNavigationController) {
        navigationBar.apply(to: styleable.navigationBar)
    }

}

extension SingleViewNavigationController: StyleApplicable {

    typealias StyleType = SingleViewNavigationStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> SingleViewNavigationStyle {
        return SingleViewNavigationStyle(theme: theme)
    }

}
