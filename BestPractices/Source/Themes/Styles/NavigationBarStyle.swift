import Themer
import UIKit

struct NavigationBarStyle: UINavigationBarStyle {

    typealias View = UILabel

    let barTintColor: UIColor?
    let backgroundColor: UIColor?

    init(theme: Theme) {
        switch theme {
        case .light:
            barTintColor = nil
        case .dark:
            barTintColor = .black
        }

        backgroundColor = nil
    }

}
