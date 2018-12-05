/// TODO: Use asset catalog with codegen for color generation

import UIKit

struct Color {

    static let black: UIColor = .black
    static let white: UIColor = .white

}

struct ColorType {

    struct Light {

        static let bodyText: UIColor = Color.black
        static let inputText: UIColor = Color.black
        static let viewBackground: UIColor? = Color.white
        static let navigationBarTint: UIColor? = nil
        static let tabBarTint: UIColor? = nil

    }

    struct Dark {

        static let bodyText: UIColor = Color.white
        static let inputText: UIColor = Color.white
        static let viewBackground: UIColor? = Color.black
        static let navigationBarTint: UIColor? = Color.black
        static let tabBarTint: UIColor? = Color.black

    }

}
