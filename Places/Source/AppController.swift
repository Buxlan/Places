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
            return textIsFirstLaunch
//            let value = UserDefaults.standard.bool(forKey: "wasLauchedBefore")
//            return !value
        }
        set {
            textIsFirstLaunch = newValue
            UserDefaults.standard.set(!newValue, forKey: Key.wasLaunchedBefore)
        }
    }
    
    var textIsFirstLaunch = true
    
    let viewController: ( (ViewControllerIdentifier) -> UIViewController ) = { identifier in
        let storyboard = UIStoryboard(name: storyboardIdentifier(identifier).rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
    }
    
    override init() {
        super.init()
        
        let bundleVersion = Bundle.main.object(forInfoDictionaryKey: Key.bundleVersion)
        if let bundleVersion = bundleVersion as? String {
            let lastExecutedVersion = UserDefaults.standard.value(forKey: Key.lastExecutedBundleVersion)
            if let lastExecutedVersion = lastExecutedVersion as? String {
                if bundleVersion != lastExecutedVersion {
                    updateVersion(old: lastExecutedVersion, new: bundleVersion)
                }
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
        case authSignUp = "authSignUp"
        case authLogin = "Login"
        case editComment = "EditComment"
        case nearestPlaces = "NearestPlaces"
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
        case authSignUp = "AuthSignUp"
        case authLogin = "Login"
        case editComment = "EditPlace"
        case nearestPlaces = "NearestPlaces"
        
    }
    
    private static let storyboardIdentifier: ((ViewControllerIdentifier) -> StoryboardIdentifier) = { identifier in
        
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
        case .authSignUp:
            return .authSignUp
        case .editComment:
            return .editComment
        case .mainTabBar:
            return .main
        case .nearestPlaces:
            return .nearestPlaces
        case .authLogin:
            return .authLogin
        }
    }
    
}

extension UIViewController {
    
    static func instantiateViewController(withIdentifier identifier: AppController.ViewControllerIdentifier) -> UIViewController {
        let appController = AppController.shared
        return appController.viewController(identifier)
    }
}
