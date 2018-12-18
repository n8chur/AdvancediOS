import ReactiveSwift
import Result
import Presentations

protocol SettingsPresentingViewModel: class, PresentingViewModel {
    var settingsPresenter: SettingsPresenter? { get set }
    var presentSettings: Action<Bool, SettingsViewModel, NoError> { get }
}

extension SettingsPresentingViewModel {

    /// Makes an action that is suitable to be set as the presentSettings action.
    ///
    /// - Parameter setupViewModel: This closure will be called with the presenting view model when a present action
    ///             is executed. Consumers can use this to observe changes to the presenting view model if necessary.
    func makePresentSettings(setupViewModel: ((SettingsViewModel) -> Void)? = nil) -> Action<Bool, SettingsViewModel, NoError> {
        return makePresent(
            getPresenter: { [weak self] in
                return self?.settingsPresenter
            },
            getViewModel: { (presenter) in
                let viewModel = presenter.makeSettingsViewModel()

                setupViewModel?(viewModel)

                return viewModel
            },
            getPresentation: { (presenter, viewModel) in
                return presenter.settingsPresentation(of: viewModel)
            },
            getContext: { (presentation, _, animated) in
                return DismissablePresentationContext(presentation: presentation, presentAnimated: animated)
            })
    }

}

protocol SettingsPresenter: class {
    func makeSettingsViewModel() -> SettingsViewModel
    func settingsPresentation(of viewModel: SettingsViewModel) -> DismissablePresentation
}
