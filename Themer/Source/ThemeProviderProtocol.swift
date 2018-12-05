import ReactiveCocoa
import ReactiveSwift

public protocol ThemeProviderProtocol {
    associatedtype ThemeType

    var theme: MutableProperty<ThemeType> { get }
}

public extension ThemeProviderProtocol {
    public func bindStyle<S: StyleApplicable & AnyObject>(for view: S) where S.ThemeType == ThemeType {
        theme.producer
            .take(duringLifetimeOf: view)
            .startWithValues { [weak view] theme in
                guard let view = view else {
                    return
                }

                let style = view.makeStyleWithTheme(theme)
                style.apply(to: view)
        }
    }
}
