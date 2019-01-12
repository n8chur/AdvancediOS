import Themer
import UIKit
import Core
import Presentations

struct TabBarControllerStyle<ViewModelType: ViewModel>: Style {
    let tabBar: TabBarStyle

    init(theme: Theme) {
        tabBar = TabBarStyle(theme: theme)
    }

    func apply(to styleable: TabBarController<ViewModelType>) {
        tabBar.apply(to: styleable.tabBar)
    }

}
