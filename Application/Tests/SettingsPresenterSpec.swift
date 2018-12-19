import Quick
import Nimble
import ReactiveSwift
import Result
import Core

@testable import Application

class SettingsPresenterSpec: QuickSpec {
    override func spec() {

        describe("SettingsPresentingViewModel") {
            describe("makePresentSettings()") {

                var presentingViewModel: StubSettingsPresentingViewModel!
                var presenter: StubSettingsPresenter!

                beforeEach {
                    presentingViewModel = StubSettingsPresentingViewModel()
                    presenter = StubSettingsPresenter()

                    presentingViewModel.settingsPresenter = presenter
                }

                it("should call the presenter to create a view model") {
                    presentingViewModel.presentSettings.apply(false).start()

                    expect(presentingViewModel.factory.makeViewModel.value).notTo(beNil())
                }

                it("should call the presenter to create a presentation context") {
                    presentingViewModel.presentSettings.apply(false).start()

                    expect(presenter.settingsPresentation.value).to(be(presentingViewModel.factory.makeViewModel.value))
                }

                it("should call the setup block") {
                    presentingViewModel.presentSettings.apply(false).start()

                    expect(presentingViewModel.setupViewModel.value).to(be(presentingViewModel.factory.makeViewModel.value))
                }
            }
        }

    }
}
