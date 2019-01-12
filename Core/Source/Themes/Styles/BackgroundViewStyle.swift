import Themer
import UIKit

public struct BackgroundViewStyle: UIViewStyle {

    public let backgroundColor: UIColor?
    public var cornerRadius: CGFloat
    public var borderWidth: CGFloat
    public var borderColor: UIColor?

    public init(theme: Theme) {
        backgroundColor = theme.color.viewBackground
        cornerRadius = 0
        borderWidth = 0
        borderColor = nil
    }

}
