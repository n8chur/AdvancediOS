import Themer
import UIKit

struct SettingsViewStyle: Style {
    typealias View = SettingsView

    let background: BackgroundViewStyle
    let themeSwitchTitle: LabelStyle

    init(theme: Theme) {
        background = BackgroundViewStyle(theme: theme)
        themeSwitchTitle = LabelStyle(theme: theme)
    }

    func apply(to view: SettingsView) {
        background.apply(to: view)
        themeSwitchTitle.apply(to: view.themeSwitchTitle)
    }

}

extension SettingsView: StyleApplicable {

    typealias StyleType = SettingsViewStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> SettingsViewStyle {
        return SettingsViewStyle(theme: theme)
    }

}
