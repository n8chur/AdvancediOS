import Themer
import ReactiveSwift

class ThemeProvider {
    let theme = MutableProperty<Theme>(.light)

    func bindStyle<S: StyleApplicable & AnyObject>(for view: S) where S.ThemeType == Theme {
        theme.producer
            .take(duringLifetimeOf: self)
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
