import Themer
import UIKit
import Core

struct DetailViewControllerStyle: Style {

    let theme: Theme
    let background: BackgroundViewStyle
    let label: LabelStyle
    let alternateLabel: AlternateLabelStyle
    let button: ButtonStyle

    init(theme: Theme) {
        self.theme = theme
        background = BackgroundViewStyle(theme: theme)
        label = LabelStyle(theme: theme)
        alternateLabel = AlternateLabelStyle(theme: theme)
        button = ButtonStyle(theme: theme)
    }

    func apply(to styleable: DetailViewController) {
        let view = styleable.detailView
        background.apply(to: view)

        label.apply(to: view.title)
        label.apply(to: view.foodListTitle)

        alternateLabel.apply(to: view.selectionResult)
        alternateLabel.apply(to: view.foodList)

        button.apply(to: view.button)
        button.apply(to: view.foodInfoButton)

        view.selectionStackView.spacing = theme.layout.interitemSpacing
        view.foodStackView.spacing = theme.layout.interitemSpacing

        view.containerStackView.spacing = theme.layout.containerSpacing
    }

}
