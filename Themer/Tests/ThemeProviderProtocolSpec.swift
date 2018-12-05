import Quick
import Nimble

@testable import Themer

class ThemeProviderProtocolSpec: QuickSpec {
    override func spec() {

        describe("ThemeProviderProtocol") {
            it("should apply themes as they are updated") {
                let view = StubView()
                let themeProvider = StubThemeProvider()

                expect(view.themeName).to(beNil())

                themeProvider.bindToStyleable(view) { StubViewStyle(theme: $0) }

                expect(view.themeName).to(equal("light"))

                themeProvider.theme.value = .dark

                expect(view.themeName).to(equal("dark"))
            }
        }

    }
}
