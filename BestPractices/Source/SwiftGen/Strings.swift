// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Detail {
    /// Details
    internal static let title = L10n.tr("Localizable", "detail.title")
    internal enum Select {
      /// Select Text
      internal static let title = L10n.tr("Localizable", "detail.select.title")
    }
  }

  internal enum Root {
    /// It works!
    internal static let testText = L10n.tr("Localizable", "root.test_text")
    internal enum PresentDetails {
      /// Details
      internal static let title = L10n.tr("Localizable", "root.present_details.title")
    }
  }

  internal enum Selection {
    internal enum Submit {
      /// Submit
      internal static let title = L10n.tr("Localizable", "selection.submit.title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
