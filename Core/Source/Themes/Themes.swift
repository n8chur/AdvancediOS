import UIKit

public enum Theme {
    case light
    case dark
}

public extension Theme {
    public var color: ColorSet {
        switch self {
        case .light: return ColorSet(
            bodyText: Color.lightContent.color,
            inputText: Color.lightContent.color,
            actionColor: Color.lightActionColor.color,
            viewBackground: Color.lightBackground.color,
            navigationBarTint: nil,
            tabBarTint: nil)
        case .dark: return ColorSet(
            bodyText: Color.darkContent.color,
            inputText: Color.darkContent.color,
            actionColor: Color.darkActionColor.color,
            viewBackground: Color.darkBackground.color,
            navigationBarTint: Color.darkBackground.color,
            tabBarTint: Color.darkBackground.color)
        }
    }

    public var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .light: return .default
        case .dark: return .lightContent
        }
    }

    public var layout: Layout {
        return Layout(
            interitemSpacing: 10,
            buttonContentEdgeInsets: UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20),
            buttonBorderWidth: 1,
            buttonCornerRadius: 12,
            contentLayoutMargins: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }
}

public struct ColorSet {
    public let bodyText: UIColor
    public let inputText: UIColor
    public let actionColor: UIColor
    public let viewBackground: UIColor?
    public let navigationBarTint: UIColor?
    public let tabBarTint: UIColor?
}

public struct Layout {
    public let interitemSpacing: CGFloat
    public let buttonContentEdgeInsets: UIEdgeInsets
    public let buttonBorderWidth: CGFloat
    public let buttonCornerRadius: CGFloat
    public let contentLayoutMargins: UIEdgeInsets
}
