import RxCocoa
import RxSwift

/// A protocol describing a class that can apply a themes to objects (e.g. a view).
public protocol ThemeProviderProtocol {
    /// The theme type of the style.
    ///
    /// This is typically an enum (e.g. .dark/.light).
    associatedtype ThemeType

    /// The current theme.
    var theme: BehaviorRelay<ThemeType> { get }
}

public extension ThemeProviderProtocol {

    /// Binds the provided styleable (typically a UIViewController) to a style.
    ///
    /// A new style is created using the provided closure whenever the theme changes, and
    /// is then applied to the styleable.
    func bindToStyleable<StyleType: Style>(_ styleable: StyleType.Styleable, makeStyle: @escaping (ThemeType) -> StyleType) where StyleType.Styleable: AnyObject & ReactiveCompatible {
        _ = theme.asObservable()
            .takeUntil(styleable.rx.deallocated)
            .subscribe(onNext: { [weak styleable] theme in
                guard let styleable = styleable else {
                    return
                }

                let style = makeStyle(theme)
                style.apply(to: styleable)
            })
    }

}
