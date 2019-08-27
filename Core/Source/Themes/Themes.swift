import UIKit

public enum Theme {
    case light
    case dark
}

public extension Theme {

    var color: ColorSet {
        switch self {
        case .light: return ColorSet(
            bodyText: Color.lightContent.color,
            alternateBodyText: Color.lightContentAlt.color,
            inputText: Color.lightContent.color,
            actionColor: Color.lightActionColor.color,
            viewBackground: Color.lightBackground.color,
            navigationBarTint: nil,
            tabBarTint: nil)
        case .dark: return ColorSet(
            bodyText: Color.darkContent.color,
            alternateBodyText: Color.darkContentAlt.color,
            inputText: Color.darkContent.color,
            actionColor: Color.darkActionColor.color,
            viewBackground: Color.darkBackground.color,
            navigationBarTint: Color.darkBackground.color,
            tabBarTint: Color.darkBackground.color)
        }
    }

    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .light: return .default
        case .dark: return .lightContent
        }
    }

    var layout: Layout {
        return Layout(
            interitemSpacing: 20,
            containerSpacing: 35,
            buttonContentEdgeInsets: UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20),
            buttonBorderWidth: 1,
            buttonCornerRadius: 12,
            contentLayoutMargins: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }

}

public struct ColorSet {

    public let bodyText: UIColor
    public let alternateBodyText: UIColor
    public let inputText: UIColor
    public let actionColor: UIColor
    public let viewBackground: UIColor?
    public let navigationBarTint: UIColor?
    public let tabBarTint: UIColor?

}

public struct Layout {

    /// Spacing between elements within an inner (or single) stackView.
    public let interitemSpacing: CGFloat

    /// Spacing between inner stackViews within an outer container stackView.
    public let containerSpacing: CGFloat

    public let buttonContentEdgeInsets: UIEdgeInsets
    public let buttonBorderWidth: CGFloat
    public let buttonCornerRadius: CGFloat
    public let contentLayoutMargins: UIEdgeInsets

}
