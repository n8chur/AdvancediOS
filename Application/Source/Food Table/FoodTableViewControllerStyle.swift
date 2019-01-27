import Themer
import UIKit
import Core

struct FoodTableViewControllerStyle: Style {

    let theme: Theme

    init(theme: Theme) {
        self.theme = theme
    }

    func apply(to styleable: FoodTableViewController) {
    }

}
