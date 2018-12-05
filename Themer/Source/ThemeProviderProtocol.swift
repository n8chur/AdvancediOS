import ReactiveCocoa
import ReactiveSwift

public protocol ThemeProviderProtocol {
    associatedtype ThemeType

    var theme: MutableProperty<ThemeType> { get }
}

public extension ThemeProviderProtocol {
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
