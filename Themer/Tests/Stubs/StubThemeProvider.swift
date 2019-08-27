import RxSwift
import RxRelay
import Themer

class StubThemeProvider: ThemeProviderProtocol {

    let theme = BehaviorRelay<StubTheme>(value: .light)

}
