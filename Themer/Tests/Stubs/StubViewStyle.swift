import Themer

struct StubViewStyle: Style {
    typealias View = StubView

    let themeName: String

    init(theme: StubTheme) {
        switch theme {
        case .light:
            themeName = "light"
        case .dark:
            themeName = "dark"
        }
    }

    func apply(to view: StubView) {
        view.themeName = themeName
    }

}

class StubView {
    var themeName: String?
}

extension StubView: StyleApplicable {

    typealias StyleType = StubViewStyle
    typealias ThemeType = StubTheme

    func makeStyleWithTheme(_ theme: StubTheme) -> StubViewStyle {
        return StubViewStyle(theme: theme)
    }

}
