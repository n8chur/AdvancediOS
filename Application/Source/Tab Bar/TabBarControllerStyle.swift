import Themer
import UIKit
import Core
import Presentations

struct TabBarControllerStyle<ViewModelType: ViewModel>: Style {
    typealias Styleable = TabBarController<ViewModelType>

    let tabBar: TabBarStyle

    init(theme: Theme) {
        tabBar = TabBarStyle(theme: theme)
    }

    func apply(to styleable: Styleable) {
        tabBar.apply(to: styleable.tabBar)
    }

}
