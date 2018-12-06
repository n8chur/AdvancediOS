import Themer
import ReactiveSwift
import Logger

public class ThemeProvider: ThemeProviderProtocol {
    public typealias ThemeType = Theme

    public let theme = MutableProperty<Theme>(.light)

    public init() {
        theme.signal
            .take(duringLifetimeOf: self)
            .logValue(.info) { "Theme changed: \($0)" }
            .observeCompleted { }
    }
}
