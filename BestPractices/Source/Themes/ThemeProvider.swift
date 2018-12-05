import Themer
import ReactiveSwift

class ThemeProvider: ThemeProviderProtocol {
    typealias ThemeType = Theme

    let theme = MutableProperty<Theme>(.light)
}
