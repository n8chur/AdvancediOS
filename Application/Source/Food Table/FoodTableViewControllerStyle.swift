import Themer
import UIKit
import Core

struct FoodTableViewControllerStyle: Style {

    let theme: Theme
    let background: BackgroundViewStyle

    init(theme: Theme) {
        self.theme = theme
        background = BackgroundViewStyle(theme: theme)
    }

    func apply(to styleable: FoodTableViewController) {
    }

}
