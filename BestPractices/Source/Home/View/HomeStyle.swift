import Themer
import UIKit
import Core

struct HomeStyle: Style {
    typealias Styleable = HomeViewController

    let background: BackgroundViewStyle
    let label: LabelStyle

    init(theme: Theme) {
        background = BackgroundViewStyle(theme: theme)
        label = LabelStyle(theme: theme)
    }

    func apply(to styleable: HomeViewController) {
        background.apply(to: styleable.homeView)
        label.apply(to: styleable.homeView.label)
    }

}

extension HomeViewController: StyleApplicable {

    typealias StyleType = HomeStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> HomeStyle {
        return HomeStyle(theme: theme)
    }

}
