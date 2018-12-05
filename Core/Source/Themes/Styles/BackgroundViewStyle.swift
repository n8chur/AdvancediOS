import Themer
import UIKit

public struct BackgroundViewStyle: UIViewStyle {

    typealias View = UIView

    public let backgroundColor: UIColor?

    public init(theme: Theme) {
        backgroundColor = theme.color.viewBackground
    }

}
