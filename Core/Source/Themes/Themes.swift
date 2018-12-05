import UIKit

public enum Theme {
    case light
    case dark
}

public extension Theme {
    public var color: ColorSet {
        switch self {
        case .light: return ColorSet(
            bodyText: Color.black,
            inputText: Color.black,
            viewBackground: Color.white,
            navigationBarTint: nil,
            tabBarTint: nil)
        case .dark: return ColorSet(
            bodyText: Color.white,
            inputText: Color.white,
            viewBackground: Color.black,
            navigationBarTint: Color.black,
            tabBarTint: Color.black)
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
