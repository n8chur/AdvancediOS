import Themer
import UIKit
import Core
import SnapKit

struct HomeViewControllerStyle: Style {
    typealias Styleable = HomeViewController

    let theme: Theme
    let background: BackgroundViewStyle
    let detailButton: ButtonStyle
    let label: LabelStyle

    init(theme: Theme) {
        self.theme = theme
        background = BackgroundViewStyle(theme: theme)
        label = LabelStyle(theme: theme)
        detailButton = ButtonStyle(theme: theme)
    }

    func apply(to styleable: HomeViewController) {
        let view = styleable.homeView

        background.apply(to: view)
        label.apply(to: view.label)
        detailButton.apply(to: view.detailButton)

        view.interitemSpacingConstraints.forEach { constraint in
            constraint.update(offset: theme.layout.interitemSpacing)
        }
    }

}
