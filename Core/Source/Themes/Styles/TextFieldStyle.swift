import Themer
import UIKit

public struct TextFieldStyle: UITextFieldStyle {

    typealias View = UILabel

    public let textColor: UIColor
    public let backgroundColor: UIColor?

    public init(theme: Theme) {
        textColor = theme.color.bodyText
        backgroundColor = nil
    }

}
