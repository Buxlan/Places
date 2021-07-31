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
        configureFirebase(for: application)
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        configureApplicationAppearance()
        
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
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification")
    }
    
    private func configureApplicationAppearance() {
        UITabBar.appearance().backgroundColor = Asset.other1.color
        UITabBar.appearance().unselectedItemTintColor = Asset.other0.color
        UITabBar.appearance().tintColor = Asset.other0.color
        UINavigationBar.appearance().backgroundColor = Asset.other1.color
        UINavigationBar.appearance().tintColor = Asset.main0.color
        UINavigationBar.appearance().barTintColor = Asset.other1.color
        
//        let attr = [NSAttributedString.Key.foregroundColor: Asset.main0.color]
//        UITabBarItem.appearance().setTitleTextAttributes(attr, for: .selected)
//        let attr2 = [NSAttributedString.Key.foregroundColor: Asset.other0.color]
//        UITabBarItem.appearance().setTitleTextAttributes(attr2, for: .normal)
    }
    
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("didReceiveRegistrationToken")
        print("Token is: \(fcmToken)")
    }
    
    private func configureFirebase(for application: UIApplication) {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        
        application.registerForRemoteNotifications()
        
        Database.database().isPersistenceEnabled = true
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
        
}
