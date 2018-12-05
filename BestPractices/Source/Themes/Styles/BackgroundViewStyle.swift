import Themer
import UIKit

struct BackgroundViewStyle: UIViewStyle {

    typealias View = UIView

    let backgroundColor: UIColor?

    init(theme: Theme) {
        switch theme {
        case .light:
            backgroundColor = .white
        case .dark:
            backgroundColor = .black
        }
    }

}
