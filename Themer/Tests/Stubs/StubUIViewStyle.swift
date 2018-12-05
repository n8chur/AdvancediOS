import Themer
import UIKit

struct StubUIViewStyle: UIViewStyle {

    typealias View = UIView

    let backgroundColor: UIColor?

    init(color: UIColor) {
        backgroundColor = color
    }

}
