import Themer
import UIKit
import Core

struct DetailViewControllerStyle: Style {
    let theme: Theme
    let background: BackgroundViewStyle
    let title: LabelStyle
    let alternateCopy: AlternateLabelStyle
    let button: ButtonStyle

    init(theme: Theme) {
        self.theme = theme
        background = BackgroundViewStyle(theme: theme)
        title = LabelStyle(theme: theme)
        alternateCopy = AlternateLabelStyle(theme: theme)
        button = ButtonStyle(theme: theme)
    }

    func apply(to styleable: DetailViewController) {
        let view = styleable.detailView
        background.apply(to: view)

        title.apply(to: view.title)
        title.apply(to: view.contentsListTitle)

        alternateCopy.apply(to: view.selectionResult)
        alternateCopy.apply(to: view.contentsList)

        button.apply(to: view.button)
        button.apply(to: view.contentsButton)

        view.stackView.spacing = theme.layout.interitemSpacing
    }

}
