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
            viewBackground: Color.lightBackground.color,
            navigationBarTint: nil,
            tabBarTint: nil)
        case .dark: return ColorSet(
            bodyText: Color.darkContent.color,
            inputText: Color.darkContent.color,
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
}

public struct ColorSet {
    public let bodyText: UIColor
    public let inputText: UIColor
    public let viewBackground: UIColor?
    public let navigationBarTint: UIColor?
    public let tabBarTint: UIColor?
}
