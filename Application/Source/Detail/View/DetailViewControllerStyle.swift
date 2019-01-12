import Themer
import UIKit
import Core

struct DetailViewControllerStyle: Style {
    let theme: Theme
    let background: BackgroundViewStyle
    let title: LabelStyle
    let selectionResult: LabelStyle
    let button: ButtonStyle

    init(theme: Theme) {
        self.theme = theme
        background = BackgroundViewStyle(theme: theme)
        title = LabelStyle(theme: theme)
        selectionResult = LabelStyle(theme: theme)
        button = ButtonStyle(theme: theme)
    }

    func apply(to styleable: DetailViewController) {
        let view = styleable.detailView

        background.apply(to: view)
        title.apply(to: view.title)
        selectionResult.apply(to: view.selectionResult)
        button.apply(to: view.button)

        view.stackView.spacing = theme.layout.interitemSpacing
    }

}
