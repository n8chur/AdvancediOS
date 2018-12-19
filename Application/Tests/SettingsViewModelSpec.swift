import Quick
import Nimble
import ReactiveSwift
import Result
import Core

@testable import Application

class SettingsViewModelSpec: QuickSpec {
    override func spec() {

        var viewModel: SettingsViewModel!

        beforeEach {
            viewModel = SettingsViewModel(themeProvider: ThemeProvider())
        }

        describe("SettingsViewModel") {
            it("should initialize with a false isActive") {
                expect(viewModel.isActive.value).to(beFalse())
            }
        }

    }
}
