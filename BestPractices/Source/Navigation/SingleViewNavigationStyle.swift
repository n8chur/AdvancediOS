import Themer
import UIKit

struct SingleViewNavigationStyle: Style {
    typealias Styleable = SingleViewNavigationController

    let background: BackgroundViewStyle
    let navigationBar: NavigationBarStyle

    init(theme: Theme) {
        background = BackgroundViewStyle(theme: theme)
        navigationBar = NavigationBarStyle(theme: theme)
    }

    func apply(to styleable: SingleViewNavigationController) {
        background.apply(to: styleable.view)
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
