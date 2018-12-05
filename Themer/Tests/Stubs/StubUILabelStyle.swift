import Themer
import UIKit

struct StubUILabelStyle: UILabelStyle {

    typealias View = UILabel

    let textColor: UIColor
    let backgroundColor: UIColor?

    init(color: UIColor) {
        textColor = color
        backgroundColor = color
    }

}
