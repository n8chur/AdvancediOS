import Themer
import UIKit

struct StubUINavigationBarStyle: UINavigationBarStyle {

    typealias View = UINavigationBar

    let barTintColor: UIColor?
    let backgroundColor: UIColor?

    init(color: UIColor) {
        barTintColor = color
        backgroundColor = color
    }

}
