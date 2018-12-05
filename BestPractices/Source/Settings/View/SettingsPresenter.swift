import ReactiveSwift
import Result
import Presentations

protocol SettingsPresentingViewModel: class, PresentingViewModel {
    var settingsPresenter: SettingsPresenter? { get set }
    var presentSettings: Action<(), Never, NoError> { get }
}

extension SettingsPresentingViewModel {

    /// Makes an action that is suitable to be set as the presentSettings action.
    ///
    /// - Parameter setupViewModel: This closure will be called with the presenting view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presenting view model if necessary.
    func makePresentSettings(setupViewModel: ((SettingsViewModel) -> Void)? = nil) -> Action<(), Never, NoError> {
        return makePresent(
            getPresenter: { [weak self] in
                return self?.settingsPresenter
            },
            getViewModel: { (presenter) in
                return presenter.makeSettingsViewModel()
            },
            setupViewModel: setupViewModel,
            getPresentationProducer: { (presenter, viewModel) in
                return presenter.settingsPresentation(of: viewModel)
            })
    }

}

protocol SettingsPresenter: class, Presenter {
    func makeSettingsViewModel() -> SettingsViewModel
    func settingsPresentationContext(of viewModel: SettingsViewModel) -> DismissablePresentationContext
}

fileprivate extension SettingsPresenter {

    func settingsPresentation(of viewModel: SettingsViewModel) -> SignalProducer<Never, NoError> {
        return makePresentation(
            of: viewModel,
            getContext: { [weak self] viewModel in
                return self?.settingsPresentationContext(of: viewModel)
        })
    }

}
