import Themer
import UIKit
import Core

struct DetailViewControllerStyle: Style {
    typealias Styleable = DetailViewController

    let theme: Theme
    let background: BackgroundViewStyle
    let title: LabelStyle
    let selectionResult: LabelStyle

    init(theme: Theme) {
        self.theme = theme
        background = BackgroundViewStyle(theme: theme)
        title = LabelStyle(theme: theme)
        selectionResult = LabelStyle(theme: theme)
    }

    func apply(to styleable: DetailViewController) {
        let view = styleable.detailView

        background.apply(to: view)
        title.apply(to: view.title)
        selectionResult.apply(to: view.selectionResult)

        view.interitemSpacingConstraints.forEach { constraint in
            constraint.update(offset: theme.layout.interitemSpacing)
        }
    }

}

extension DetailViewController: StyleApplicable {

    typealias StyleType = DetailViewControllerStyle
    typealias ThemeType = Theme

    func makeStyleWithTheme(_ theme: Theme) -> DetailViewControllerStyle {
        return DetailViewControllerStyle(theme: theme)
    }

}
