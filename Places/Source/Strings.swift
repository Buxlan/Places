// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum App {
    /// Place
    internal static let name = L10n.tr("Localizable", "App.name")
  }

  internal enum Auth {
    /// Forget password?
    internal static let forgotPassword = L10n.tr("Localizable", "Auth.forgotPassword")
    /// Password
    internal static let passwordPlaceholder = L10n.tr("Localizable", "Auth.passwordPlaceholder")
    /// Joining us allow to share you own essay about variable places...
    internal static let title = L10n.tr("Localizable", "Auth.title")
    /// Username / E-mail
    internal static let usernamePlaceholder = L10n.tr("Localizable", "Auth.usernamePlaceholder")
    internal enum Buttons {
      /// Login
      internal static let login = L10n.tr("Localizable", "Auth.Buttons.Login")
      /// Sign up now
      internal static let signUp = L10n.tr("Localizable", "Auth.Buttons.signUp")
    }
  }

  internal enum FavoritePlaces {
    /// Favorite
    internal static let title = L10n.tr("Localizable", "FavoritePlaces.title")
  }

  internal enum NearestPlaces {
    /// Nearby
    internal static let title = L10n.tr("Localizable", "NearestPlaces.title")
  }

  internal enum Onboarding {
    /// We're glad to see you at Place. Here are we're sharing thoughts, dreams and imaginations about favorite Saint-petersburg places
    internal static let onboardngText1 = L10n.tr("Localizable", "Onboarding.onboardngText1")
    /// Share your imaginations! Listen and share audio, text and pictures with other
    internal static let onboardngText2 = L10n.tr("Localizable", "Onboarding.onboardngText2")
    /// Joining us allow to share you own essay about variable places...
    internal static let onboardngText3 = L10n.tr("Localizable", "Onboarding.onboardngText3")
    /// Welcome
    internal static let onboardngTitle1 = L10n.tr("Localizable", "Onboarding.onboardngTitle1")
    /// Look, learn and share
    internal static let onboardngTitle2 = L10n.tr("Localizable", "Onboarding.onboardngTitle2")
    /// Join to us
    internal static let onboardngTitle3 = L10n.tr("Localizable", "Onboarding.onboardngTitle3")
    internal enum Buttons {
      /// Next (1 from 3)
      internal static let futher1 = L10n.tr("Localizable", "Onboarding.Buttons.futher1")
      /// Next (2 from 3)
      internal static let futher2 = L10n.tr("Localizable", "Onboarding.Buttons.futher2")
      /// Maybe later
      internal static let later = L10n.tr("Localizable", "Onboarding.Buttons.Later")
      /// Skip
      internal static let skip = L10n.tr("Localizable", "Onboarding.Buttons.Skip")
    }
  }

  internal enum PlacesList {
    /// Top
    internal static let title = L10n.tr("Localizable", "PlacesList.title")
    /// Go to reviews
    internal static let toReviews = L10n.tr("Localizable", "PlacesList.toReviews")
  }

  internal enum Profile {
    /// Profile
    internal static let title = L10n.tr("Localizable", "Profile.title")
    internal enum Buttons {
      /// Sign in
      internal static let signIn = L10n.tr("Localizable", "Profile.Buttons.SignIn")
      /// Register
      internal static let signUp = L10n.tr("Localizable", "Profile.Buttons.SignUp")
    }
  }

  internal enum SignIn {
    /// Login
    internal static let title = L10n.tr("Localizable", "SignIn.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
