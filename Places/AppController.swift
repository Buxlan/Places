//
//  AppController.swift
//  Places
//
//  Created by  Buxlan on 5/27/21.
//

import Foundation
import UIKit

class AppController: NSObject {
    
    // MARK: - Public
    
    struct Key {
        static let wasLaunchedBefore = "wasLauchedBefore"
        static let bundleVersion = "CFBundleVersion"
        static let lastExecutedBundleVersion = "LastExecutedBundleVersion"
    }
    
    static let shared = AppController()
    
    let settings = AppSettings()
    var config: Config {
        settings.config
    }
    
    var isFirstLaunch: Bool {
        get {
            return true
//            let value = UserDefaults.standard.bool(forKey: "wasLauchedBefore")
//            return !value
        }
        set {
            UserDefaults.standard.set(!newValue, forKey: Key.wasLaunchedBefore)
        }
    }
    
    let viewController: ( (ViewControllerIdentifier) -> UIViewController ) = { identifier in
        let storyboard = UIStoryboard(name: storyboardIdentifier(identifier).rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
    }
    
    override init() {
        super.init()
        
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: Key.bundleVersion) as! String
        if let lastExecutedVersion =
            UserDefaults.standard.value(forKey: Key.lastExecutedBundleVersion)
            as? String {
            if currentVersion != lastExecutedVersion {
                updateVersion(old: lastExecutedVersion, new: currentVersion)
            }
        }
    }
    
    // MARK: - Private
    
    private func updateVersion(old: String, new: String) {
        Utils.log("updating version to ", object: new)
        UserDefaults.standard.set(new, forKey: Key.lastExecutedBundleVersion)
    }
    
    private enum StoryboardIdentifier: String {
        case placeComments = "PlaceComments"
        case main = "Main"
        case root = "Root"
        case onboarding = "Onboarding"
        case launchScreen = "LaunchScreen"
        case place = "Place"
        case favorites = "Favorites"
        case profile = "Profile"
        case placeList = "PlaceList"
        case authLogin = "AuthLogin"
        case authSignIn = "AuthSignIn"
        case editComment = "EditComment"
    }
    
    enum ViewControllerIdentifier: String, CaseIterable {
        case entry = "EntryPoint"
        case onboarding = "Onboarding"
        case onboarding1 = "OnboardingFirst"
        case onboarding2 = "OnboardingSecond"
        case onboarding3 = "OnboardingThird"
        case mainTabBar = "MainTabBar"
        case main = "Main"
        case place = "Place"
        case placeList = "PlaceList"
        case placeComments = "Comments"
        case favorites = "Favorites"
        case profile = "Profile"
        case authLogin = "AuthLogin"
        case registration = "Registration"
        case editComment = "EditPlace"
        
    }
    
    private static let storyboardIdentifier: ( (ViewControllerIdentifier) -> StoryboardIdentifier) = { (identifier: ViewControllerIdentifier) -> StoryboardIdentifier in
        switch identifier {
        case .entry:
            return .main
        case .main :
            return .main
        case .onboarding :
            return .onboarding
        case .onboarding1 :
            return .onboarding
        case .onboarding2 :
            return .onboarding
        case .onboarding3 :
            return .onboarding
        case .place :
            return .place
        case .placeList:
            return .placeList
        case .placeComments:
            return .placeComments
        case .favorites:
            return .favorites
        case .profile:
            return .profile
        case .authLogin:
            return .authLogin
        case .registration:
            return .authSignIn
        case .editComment:
            return .editComment
        case .mainTabBar:
            return .main
        }
    }
    
}

extension UIViewController {
    
    static func instantiateViewController(withIdentifier identifier: AppController.ViewControllerIdentifier) -> UIViewController {
        let appController = AppController.shared
        return appController.viewController(identifier)
    }
}


