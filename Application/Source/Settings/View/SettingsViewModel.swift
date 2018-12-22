import RxSwift
import RxCocoa
import RxExtensions
import Presentations
import Core

class SettingsViewModel: ViewModel {

    let isActive = BehaviorRelay(value: false)

    let themeSwitchTitle = Property(L10n.Settings.ThemeSwitch.title)

    /// Initializes with a value representing whether the theme provider's theme is
    /// currently the dark theme.
    ///
    /// This should be set to switch between the dark and light themes.
    let isDarkTheme: BehaviorRelay<Bool>

    init(themeProvider: ThemeProvider) {
        isDarkTheme = BehaviorRelay(value: themeProvider.theme.value == .dark)

        isDarkTheme
            .map { return $0 ? .dark : .light }
            .bind(to: themeProvider.theme)
            .disposed(by: disposeBag)
    }

    private func isDark(theme: Theme) -> Bool {
        switch theme {
        case .dark:
            return true
        case .light:
            return false
        }
    }

    private let disposeBag = DisposeBag()

}

protocol SettingsViewModelFactoryProtocol {
    var themeProvider: ThemeProvider { get }

    func makeSettingsViewModel() -> SettingsViewModel
}

extension SettingsViewModelFactoryProtocol {

    func makeSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(themeProvider: themeProvider)
    }

}
