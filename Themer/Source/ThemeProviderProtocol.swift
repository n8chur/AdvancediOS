import ReactiveCocoa
import ReactiveSwift

/// A protocol describing a class that can apply a themes to objects (e.g. a view).
public protocol ThemeProviderProtocol {
    /// The theme type of the style.
    ///
    /// This is typically an enum (e.g. .dark/.light).
    associatedtype ThemeType

    /// The current theme.
    var theme: MutableProperty<ThemeType> { get }
}

public extension ThemeProviderProtocol {

    /// Binds the provided styleable's style to itself.
    ///
    /// This will cause the style to update the styleable whenever the theme changes.
    public func bindStyle<S: StyleApplicable & AnyObject>(for styleable: S) where S.ThemeType == ThemeType {
        theme.producer
            .take(duringLifetimeOf: styleable)
            .startWithValues { [weak styleable] theme in
                guard let styleable = styleable else {
                    return
                }

                let style = styleable.makeStyleWithTheme(theme)
                style.apply(to: styleable)
        }
    }

}
