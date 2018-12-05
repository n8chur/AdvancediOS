import Themer
import UIKit

struct StubUIButtonStyle: UIButtonStyle {

    typealias View = UIButton

    let titleColor: UIColor?
    let contentEdgeInsets: UIEdgeInsets
    let backgroundColor: UIColor?
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    let borderColor: UIColor?

}
