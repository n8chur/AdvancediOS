import Themer
import UIKit

struct SettingsStyle: Style {
    typealias Styleable = SettingsViewController

    let background: BackgroundViewStyle
    let themeSwitchTitle: LabelStyle

    init(theme: Theme) {
        background = BackgroundViewStyle(theme: theme)
        themeSwitchTitle = LabelStyle(theme: theme)
    }

    func apply(to styleable: SettingsViewController) {
        background.apply(to: styleable.settingsView)
        themeSwitchTitle.apply(to: styleable.settingsView.themeSwitchTitle)
    }

}

extension SettingsViewController: StyleApplicable {

    typealias StyleType = SettingsStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> SettingsStyle {
        return SettingsStyle(theme: theme)
    }

}
