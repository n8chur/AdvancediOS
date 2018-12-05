import ReactiveSwift

class SettingsNavigationModel: TabBarChildViewModel, SettingsPresentingViewModel {

    let isActive = MutableProperty<Bool>(false)

    let tabBarItemTitle = Property(value: L10n.SettingsNavigation.TabBarItem.title)

    private(set) lazy var presentSettings = makePresentSettings()

    weak var settingsPresenter: SettingsPresenter?

    init() { }

}

protocol SettingsNavigationModelFactory: SettingsViewModelFactoryProtocol { }

extension SettingsNavigationModelFactory {

    func makeSettingsNavigationModel() -> SettingsNavigationModel {
        return SettingsNavigationModel()
    }

}
