import Themer
import UIKit

struct LabelStyle: UILabelStyle {

    typealias View = UILabel

    let textColor: UIColor
    let backgroundColor: UIColor?

    init(theme: Theme) {
        switch theme {
        case .light:
            textColor = .black
        case .dark:
            textColor = .white
        }

        backgroundColor = .clear
    }

}
