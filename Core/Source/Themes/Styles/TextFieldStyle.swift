import Themer
import UIKit

public struct TextFieldStyle: UITextFieldStyle {

    public let textColor: UIColor

    public init(theme: Theme) {
        textColor = theme.color.alternateBodyText
    }

}
