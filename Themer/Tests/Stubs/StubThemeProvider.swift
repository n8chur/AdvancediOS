import RxSwift
import Themer

class StubThemeProvider: ThemeProviderProtocol {

    typealias ThemeType = StubTheme

    let theme = Variable<StubTheme>(.light)

}
