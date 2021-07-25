//
//  AppDelegate.swift
//  Places
//
//  Created by  Buxlan on 5/1/21.
//

import UIKit
import Firebase
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        window?.tintColor = Asset.foreground0.color
        
        UITabBar.appearance().backgroundColor = Asset.background2.color
        UITabBar.appearance().unselectedItemTintColor = Asset.foreground0.color
        UITabBar.appearance().tintColor = Asset.foreground3.color
        UINavigationBar.appearance().backgroundColor = Asset.background2.color
        UINavigationBar.appearance().tintColor = Asset.foreground1.color
        UINavigationBar.appearance().barTintColor = Asset.background1.color
        
        let attr = [NSAttributedString.Key.foregroundColor: Asset.foreground1.color]
        UITabBarItem.appearance().setTitleTextAttributes(attr, for: .selected)
        let attr2 = [NSAttributedString.Key.foregroundColor: Asset.foreground0.color]
        UITabBarItem.appearance().setTitleTextAttributes(attr2, for: .normal)
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
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
