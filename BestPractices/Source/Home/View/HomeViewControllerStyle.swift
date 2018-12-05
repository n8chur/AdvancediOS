import Themer
import UIKit
import Core
import SnapKit

struct HomeViewControllerStyle: Style {
    typealias Styleable = HomeViewController

    let theme: Theme
    let background: BackgroundViewStyle
    let label: LabelStyle

    init(theme: Theme) {
        self.theme = theme
        background = BackgroundViewStyle(theme: theme)
        label = LabelStyle(theme: theme)
    }

    func apply(to styleable: HomeViewController) {
        let view = styleable.homeView

        background.apply(to: view)
        label.apply(to: view.label)

        view.interitemSpacingConstraints.forEach { constraint in
            constraint.update(offset: theme.layout.interitemSpacing)
        }
    }

}

extension HomeViewController: StyleApplicable {

    typealias StyleType = HomeViewControllerStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> HomeViewControllerStyle {
        return HomeViewControllerStyle(theme: theme)
    }

}
