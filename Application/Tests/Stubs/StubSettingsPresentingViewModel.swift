import RxSwift
import Presentations
import Core

@testable import Application

class StubSettingsPresentingViewModel: SettingsPresentingViewModel {

    let setupViewModel = MutableProperty<SettingsViewModel?>(nil)

    weak var settingsPresenter: SettingsPresenter?

    private(set) lazy var presentSettings = makePresentSettings(withFactory: factory) { [unowned self] viewModel in
        self.setupViewModel.value = viewModel
    }

    let isActive = MutableProperty<Bool>(false)

    let factory = StubSettingsViewModelFactory()

}

class StubSettingsViewModelFactory: SettingsViewModelFactoryProtocol {

    let themeProvider = ThemeProvider()

    let makeViewModel = MutableProperty<SettingsViewModel?>(nil)

    func makeSettingsViewModel() -> SettingsViewModel {
        let viewModel = SettingsViewModel(themeProvider: themeProvider)
        makeViewModel.value = viewModel
        return viewModel
    }

}
