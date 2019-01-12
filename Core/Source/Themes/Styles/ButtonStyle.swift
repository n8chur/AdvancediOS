import Themer
import UIKit

public struct ButtonStyle: UIButtonStyle {

    public let titleColor: UIColor?
    public let contentEdgeInsets: UIEdgeInsets
    public let backgroundColor: UIColor?
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let borderColor: UIColor?

    public init(theme: Theme) {
        // Use tintColor
        titleColor = theme.color.actionColor
        contentEdgeInsets = theme.layout.buttonContentEdgeInsets
        backgroundColor = nil
        cornerRadius = theme.layout.buttonCornerRadius
        borderWidth = theme.layout.buttonBorderWidth
        borderColor = theme.color.actionColor
    }

}
