import Themer
import UIKit
import Core

struct SettingsViewControllerStyle: Style {
    typealias Styleable = SettingsViewController

    let theme: Theme
    let background: BackgroundViewStyle
    let themeSwitchTitle: LabelStyle

    init(theme: Theme) {
        self.theme = theme
        background = BackgroundViewStyle(theme: theme)
        themeSwitchTitle = LabelStyle(theme: theme)
    }

    func apply(to styleable: SettingsViewController) {
        let view = styleable.settingsView

        background.apply(to: view)
        themeSwitchTitle.apply(to: view.themeSwitchTitle)

        view.themeSwitchStack.spacing = theme.layout.interitemSpacing
    }

}
