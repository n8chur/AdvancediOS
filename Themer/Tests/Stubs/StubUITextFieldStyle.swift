import Themer
import UIKit

struct StubUITextFieldStyle: UITextFieldStyle {

    typealias View = UITextField

    let textColor: UIColor
    let backgroundColor: UIColor?

    init(color: UIColor) {
        textColor = color
        backgroundColor = color
    }

}
