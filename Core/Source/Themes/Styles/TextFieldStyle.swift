import Themer
import UIKit

public struct TextFieldStyle: UITextFieldStyle {

    typealias View = UILabel

    public let textColor: UIColor

    public init(theme: Theme) {
        textColor = theme.color.bodyText
    }

}
