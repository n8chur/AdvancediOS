import RxSwift
import Presentations

@testable import Application

class StubSettingsPresenter {

    let settingsPresentation = MutableProperty<SettingsViewModel?>(nil)

}

extension StubSettingsPresenter: SettingsPresenter {

    func settingsPresentation(of viewModel: SettingsViewModel) -> DismissablePresentation {
        settingsPresentation.value = viewModel
        return DismissablePresentation.stub()
    }

}
