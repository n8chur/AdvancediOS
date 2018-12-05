import Themer
import UIKit

struct HomeViewStyle: Style {
    typealias View = HomeView

    let background: BackgroundViewStyle
    let label: LabelStyle

    init(theme: Theme) {
        background = BackgroundViewStyle(theme: theme)
        label = LabelStyle(theme: theme)
    }

    func apply(to view: HomeView) {
        background.apply(to: view)
        label.apply(to: view.label)
    }

}

extension HomeView: StyleApplicable {

    typealias StyleType = HomeViewStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> HomeViewStyle {
        return HomeViewStyle(theme: theme)
    }

}
