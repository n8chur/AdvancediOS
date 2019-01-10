import RxSwift
import Themer

class StubThemeProvider: ThemeProviderProtocol {

    let theme = Variable<StubTheme>(.light)

}
