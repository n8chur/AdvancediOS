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
        return makePresentAction { [weak self] animated -> DismissablePresentationContext<SettingsViewModel>? in
            guard
                let self = self,
                let presenter = self.settingsPresenter else {
                    return nil
            }

            let viewModel = presenter.makeSettingsViewModel()

            setupViewModel?(viewModel)

            let presentation = presenter.settingsPresentation(of: viewModel)

            return DismissablePresentationContext(presentation: presentation, viewModel: viewModel, presentAnimated: animated)
        }
    }

}

protocol SettingsPresenter: class {
    func makeSettingsViewModel() -> SettingsViewModel
    func settingsPresentation(of viewModel: SettingsViewModel) -> DismissablePresentation
}
