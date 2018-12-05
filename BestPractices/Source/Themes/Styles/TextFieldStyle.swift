import Themer
import UIKit

struct TextFieldStyle: UITextFieldStyle {

    typealias View = UILabel

    let textColor: UIColor
    let backgroundColor: UIColor?

    init(theme: Theme) {
        switch theme {
        case .light:
            textColor = ColorType.Light.bodyText
        case .dark:
            textColor = ColorType.Dark.bodyText
        }

        backgroundColor = nil
    }

}
