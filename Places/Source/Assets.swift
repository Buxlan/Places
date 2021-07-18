// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let apple = ImageAsset(name: "Apple")
  internal static let facebook = ImageAsset(name: "Facebook")
  internal static let gitHub = ImageAsset(name: "GitHub")
  internal static let google = ImageAsset(name: "Google")
  internal static let microsoft = ImageAsset(name: "Microsoft")
  internal static let twitter = ImageAsset(name: "Twitter")
  internal static let yahoo = ImageAsset(name: "Yahoo")
  internal static let appTintColor = ColorAsset(name: "appTintColor")
  internal static let background = ColorAsset(name: "background")
  internal static let controlBackground = ColorAsset(name: "controlBackground")
  internal static let darkText = ColorAsset(name: "darkText")
  internal static let lightText = ColorAsset(name: "lightText")
  internal static let placeholderText = ColorAsset(name: "placeholderText")
  internal static let secondaryText = ColorAsset(name: "secondaryText")
  internal static let tertiaryText = ColorAsset(name: "tertiaryText")
  internal static let firebaseIcon = ImageAsset(name: "firebaseIcon")
  internal static let firebaseLogo = ImageAsset(name: "firebaseLogo")
  internal static let arrowRight = ImageAsset(name: "arrow.right")
  internal static let buildingColumns = ImageAsset(name: "building.columns")
  internal static let camera = ImageAsset(name: "camera")
  internal static let favoriteFill = ImageAsset(name: "favorite.fill")
  internal static let favorite = ImageAsset(name: "favorite")
  internal static let lock = ImageAsset(name: "lock")
  internal static let map = ImageAsset(name: "map")
  internal static let micFill = ImageAsset(name: "mic.fill")
  internal static let mic = ImageAsset(name: "mic")
  internal static let person = ImageAsset(name: "person")
  internal static let login = ImageAsset(name: "login")
  internal static let logo = ImageAsset(name: "logo")
  internal static let onboarding1 = ImageAsset(name: "onboarding1")
  internal static let onboarding2 = ImageAsset(name: "onboarding2")
  internal static let menuIcon = ImageAsset(name: "menuIcon")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
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
