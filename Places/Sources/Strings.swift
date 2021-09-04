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
    /// Begin without registration
    internal static let anonymousSignIn = L10n.tr("Localizable", "Auth.anonymousSignIn")
    /// Sign in with Apple
    internal static let appleSignIn = L10n.tr("Localizable", "Auth.appleSignIn")
    /// Choose a login flow from one of the identity providers above.
    internal static let authDescription = L10n.tr("Localizable", "Auth.authDescription")
    /// Log in with:
    internal static let authProvidersTitle = L10n.tr("Localizable", "Auth.authProvidersTitle")
    /// Email & Password login
    internal static let emailPasswordSignIn = L10n.tr("Localizable", "Auth.emailPasswordSignIn")
    /// Login with Facebook
    internal static let facebookSignIn = L10n.tr("Localizable", "Auth.facebookSignIn")
    /// Places authorization
    internal static let firebaseSectionHeader = L10n.tr("Localizable", "Auth.firebaseSectionHeader")
    /// Forget password?
    internal static let forgotPassword = L10n.tr("Localizable", "Auth.forgotPassword")
    /// Sign in with Google
    internal static let googleSignIn = L10n.tr("Localizable", "Auth.googleSignIn")
    /// Password
    internal static let passwordPlaceholder = L10n.tr("Localizable", "Auth.passwordPlaceholder")
    /// Sign up now
    internal static let signUp = L10n.tr("Localizable", "Auth.signUp")
    /// Joining us allow to share you own essay about variable places...
    internal static let title = L10n.tr("Localizable", "Auth.title")
    /// Username / E-mail
    internal static let usernamePlaceholder = L10n.tr("Localizable", "Auth.usernamePlaceholder")
    internal enum Buttons {
      /// Login
      internal static let login = L10n.tr("Localizable", "Auth.Buttons.Login")
      /// Haven't account?
      internal static let signUpSectionTitle = L10n.tr("Localizable", "Auth.Buttons.signUpSectionTitle")
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
    /// Change password
    internal static let changePassword = L10n.tr("Localizable", "Profile.changePassword")
    /// Change user photo
    internal static let changeUserPhoto = L10n.tr("Localizable", "Profile.changeUserPhoto")
    /// Communication
    internal static let communication = L10n.tr("Localizable", "Profile.communication")
    /// Edit profile
    internal static let edit = L10n.tr("Localizable", "Profile.edit")
    /// Log out
    internal static let logout = L10n.tr("Localizable", "Profile.logout")
    /// Privacy
    internal static let privacy = L10n.tr("Localizable", "Profile.privacy")
    /// Profile
    internal static let title = L10n.tr("Localizable", "Profile.title")
    internal enum Buttons {
      /// Sign in
      internal static let signIn = L10n.tr("Localizable", "Profile.Buttons.SignIn")
      /// Register
      internal static let signUp = L10n.tr("Localizable", "Profile.Buttons.SignUp")
    }
  }

  internal enum Settings {
    /// Allow e-mails
    internal static let allowEmails = L10n.tr("Localizable", "Settings.allowEmails")
    /// Allow notifications
    internal static let allowNotifications = L10n.tr("Localizable", "Settings.allowNotifications")
    /// Crash reports
    internal static let crashReposts = L10n.tr("Localizable", "Settings.crashReposts")
    /// Email
    internal static let emails = L10n.tr("Localizable", "Settings.emails")
    /// Notifications
    internal static let notifications = L10n.tr("Localizable", "Settings.notifications")
    internal enum SectionTitles {
      /// Communication
      internal static let communication = L10n.tr("Localizable", "Settings.SectionTitles.communication")
      /// General
      internal static let general = L10n.tr("Localizable", "Settings.SectionTitles.general")
      /// Privacy
      internal static let privacy = L10n.tr("Localizable", "Settings.SectionTitles.privacy")
    }
  }

  internal enum SignIn {
    /// Login
    internal static let title = L10n.tr("Localizable", "SignIn.title")
  }

  internal enum User {
    /// Unregistered user
    internal static let displayUnregistered = L10n.tr("Localizable", "User.displayUnregistered")
    /// Unregistered
    internal static let unregistered = L10n.tr("Localizable", "User.unregistered")
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
