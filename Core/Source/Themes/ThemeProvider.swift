import Themer
import ReactiveSwift

public class ThemeProvider: ThemeProviderProtocol {
    public typealias ThemeType = Theme

    public let theme = MutableProperty<Theme>(.light)

    public init() { }
}
