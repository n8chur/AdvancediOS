import RxCocoa
import Presentations

@testable import Application

class StubSettingsPresenter {

    let settingsPresentation = BehaviorRelay<SettingsViewModel?>(value: nil)

}

extension StubSettingsPresenter: SettingsPresenter {

    func settingsPresentation(of viewModel: SettingsViewModel) -> DismissablePresentation {
        settingsPresentation.accept(viewModel)
        return DismissablePresentation.stub()
    }

}
