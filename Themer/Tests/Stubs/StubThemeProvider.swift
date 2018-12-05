import ReactiveSwift
import Themer

class StubThemeProvider: ThemeProviderProtocol {

    typealias ThemeType = StubTheme

    let theme = MutableProperty<StubTheme>(.light)

}
