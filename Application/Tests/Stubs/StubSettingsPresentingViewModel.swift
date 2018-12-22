import RxCocoa
import Presentations
import Core

@testable import Application

class StubSettingsPresentingViewModel: SettingsPresentingViewModel {

    let setupViewModel = BehaviorRelay<SettingsViewModel?>(value: nil)

    weak var settingsPresenter: SettingsPresenter?

    private(set) lazy var presentSettings = makePresentSettings(withFactory: factory) { [unowned self] viewModel in
        self.setupViewModel.accept(viewModel)
    }

    let isActive = BehaviorRelay<Bool>(value: false)

    let factory = StubSettingsViewModelFactory()

}

class StubSettingsViewModelFactory: SettingsViewModelFactoryProtocol {

    let themeProvider = ThemeProvider()

    let makeViewModel = BehaviorRelay<SettingsViewModel?>(value: nil)

    func makeSettingsViewModel() -> SettingsViewModel {
        let viewModel = SettingsViewModel(themeProvider: themeProvider)
        makeViewModel.accept(viewModel)
        return viewModel
    }

}
