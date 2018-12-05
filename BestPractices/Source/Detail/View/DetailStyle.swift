import Themer
import UIKit

struct DetailStyle: Style {
    typealias Styleable = DetailViewController

    let background: BackgroundViewStyle
    let title: LabelStyle
    let selectionResult: LabelStyle

    init(theme: Theme) {
        background = BackgroundViewStyle(theme: theme)
        title = LabelStyle(theme: theme)
        selectionResult = LabelStyle(theme: theme)
    }

    func apply(to styleable: DetailViewController) {
        background.apply(to: styleable.detailView)
        title.apply(to: styleable.detailView.title)
        selectionResult.apply(to: styleable.detailView.selectionResult)
    }

}

extension DetailViewController: StyleApplicable {

    typealias StyleType = DetailStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> DetailStyle {
        return DetailStyle(theme: theme)
    }

}
