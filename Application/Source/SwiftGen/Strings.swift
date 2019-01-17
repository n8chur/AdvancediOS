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
    internal enum ContentsButton {
      /// Contents Info
      internal static let title = L10n.tr("Localizable", "detail.contents_button.title")
    }
    internal enum ContentsList {
      /// Contents
      internal static let title = L10n.tr("Localizable", "detail.contents_list.title")
    }
    internal enum Select {
      /// Select Text
      internal static let title = L10n.tr("Localizable", "detail.select.title")
    }
  }

  internal enum DetailNavigation {
    internal enum TabBarItem {
      /// Detail
      internal static let title = L10n.tr("Localizable", "detail_navigation.tab_bar_item.title")
    }
  }

  internal enum Food {
    /// Beans
    internal static let beans = L10n.tr("Localizable", "food.beans")
    /// Greens
    internal static let greens = L10n.tr("Localizable", "food.greens")
    /// Potatoes
    internal static let potatoes = L10n.tr("Localizable", "food.potatoes")
    /// Tomatoes
    internal static let tomatoes = L10n.tr("Localizable", "food.tomatoes")
  }

  internal enum Home {
    /// It works!
    internal static let testText = L10n.tr("Localizable", "home.test_text")
    internal enum PresentDetail {
      /// Details
      internal static let title = L10n.tr("Localizable", "home.present_detail.title")
    }
  }

  internal enum HomeNavigation {
    internal enum TabBarItem {
      /// Home
      internal static let title = L10n.tr("Localizable", "home_navigation.tab_bar_item.title")
    }
  }

  internal enum Selection {
    internal enum Submit {
      /// Submit
      internal static let title = L10n.tr("Localizable", "selection.submit.title")
    }
  }

  internal enum Settings {
    internal enum ThemeSwitch {
      /// Dark Mode
      internal static let title = L10n.tr("Localizable", "settings.theme_switch.title")
    }
  }

  internal enum SettingsNavigation {
    internal enum TabBarItem {
      /// Settings
      internal static let title = L10n.tr("Localizable", "settings_navigation.tab_bar_item.title")
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
