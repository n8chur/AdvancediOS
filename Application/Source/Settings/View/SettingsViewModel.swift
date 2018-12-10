import ReactiveSwift
import Result
import Presentations
import Core

class SettingsViewModel: ViewModel {

    let isActive = MutableProperty(false)

    let themeSwitchTitle = Property(value: L10n.Settings.ThemeSwitch.title)

    /// Initializes with a value representing whether the theme provider's theme is
    /// currently the dark theme.
    ///
    /// This should be set to switch between the dark and light themes.
    let isDarkTheme: MutableProperty<Bool>

    init(themeProvider: ThemeProvider) {
        isDarkTheme = MutableProperty(themeProvider.theme.value == .dark)

        themeProvider.theme <~ isDarkTheme.map { return $0 ? .dark : .light }
    }

    private func isDark(theme: Theme) -> Bool {
        switch theme {
        case .dark:
            return true
        case .light:
            return false
        }
    }

}

protocol SettingsViewModelFactoryProtocol {
    var themeProvider: ThemeProvider { get }
}

extension SettingsViewModelFactoryProtocol {

    func makeSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(themeProvider: themeProvider)
    }

}
