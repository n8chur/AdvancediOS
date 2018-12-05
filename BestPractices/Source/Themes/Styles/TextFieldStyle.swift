import Themer
import UIKit

struct TextFieldStyle: UITextFieldStyle {

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
