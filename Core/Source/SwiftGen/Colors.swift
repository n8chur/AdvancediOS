// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  public typealias ColorType = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  public typealias ColorType = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
public struct Color {
  public let rgbaValue: UInt32
  public var color: ColorType { return ColorType(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#15b7ed"></span>
  /// Alpha: 100% <br/> (0x15b7edff)
  public static let darkActionColor = Color(rgbaValue: 0x15b7edff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  public static let darkBackground = Color(rgbaValue: 0x000000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d3d3d3"></span>
  /// Alpha: 100% <br/> (0xd3d3d3ff)
  public static let darkContent = Color(rgbaValue: 0xd3d3d3ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#11a4d6"></span>
  /// Alpha: 100% <br/> (0x11a4d6ff)
  public static let lightActionColor = Color(rgbaValue: 0x11a4d6ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  public static let lightBackground = Color(rgbaValue: 0xffffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  public static let lightContent = Color(rgbaValue: 0x000000ff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
public extension ColorType {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

public extension ColorType {
  convenience init(named color: Color) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
