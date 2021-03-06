//
//  AppDelegate.swift
//  Places
//
//  Created by  Buxlan on 5/1/21.
//

import UIKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
                
        window?.tintColor = Asset.other0.color
        
        UITabBar.appearance().backgroundColor = Asset.other1.color
        UITabBar.appearance().unselectedItemTintColor = Asset.other0.color
        UITabBar.appearance().tintColor = Asset.other0.color
        UINavigationBar.appearance().backgroundColor = Asset.other1.color
        UINavigationBar.appearance().tintColor = Asset.main0.color
        UINavigationBar.appearance().barTintColor = Asset.other1.color
        
        let attr = [NSAttributedString.Key.foregroundColor: Asset.main0.color]
        UITabBarItem.appearance().setTitleTextAttributes(attr, for: .selected)
        let attr2 = [NSAttributedString.Key.foregroundColor: Asset.other0.color]
        UITabBarItem.appearance().setTitleTextAttributes(attr2, for: .normal)
        
//        let encoder = JSONEncoder()
//        if let data = try? encoder.encode(PlaceUser.unsignedUser) {
//            UserDefaults.standard.register(defaults:
//                                            [UserDefaultKey.loggedUser.rawValue: data])
//        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration",
                                    sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Application Appearance

//    private func configureApplicationAppearance() {
//      UINavigationBar.appearance().tintColor = .red
//      UITabBar.appearance().tintColor = .red
//    }
    
}
