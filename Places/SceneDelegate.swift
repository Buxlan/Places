//
//  SceneDelegate.swift
//  Places
//
//  Created by  Buxlan on 5/1/21.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    lazy var authNavController: UINavigationController = {
      let navController = UINavigationController(rootViewController: AuthViewController())
      navController.view.backgroundColor = .systemBackground
      return navController
    }()

    lazy var userNavController: UINavigationController = {
      let navController = UINavigationController(rootViewController: UserViewController())
      navController.view.backgroundColor = .systemBackground
      return navController
    }()

    lazy var tabBarController: UITabBarController = {
      let tabBarController = MainTabBarViewController()
      tabBarController.delegate = tabBarController
      tabBarController.view.backgroundColor = .systemBackground
      return tabBarController
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        configureControllers()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
      if let incomingURL = userActivity.webpageURL {
        handleIncomingDynamicLink(incomingURL)
      }
    }

    // MARK: - Firebase 🔥

    private func handleIncomingDynamicLink(_ incomingURL: URL) {
      DynamicLinks.dynamicLinks().handleUniversalLink(incomingURL) { dynamicLink, error in
        guard error == nil else {
          return print("ⓧ Error in \(#function): \(error!.localizedDescription)")
        }

        guard let link = dynamicLink?.url?.absoluteString else { return }

        if Auth.auth().isSignIn(withEmailLink: link) {
          // Save the link as it will be used in the next step to complete login
          UserDefaults.standard.set(link, forKey: "Link")

          // Post a notification to the PasswordlessViewController to resume authentication
          NotificationCenter.default
            .post(Notification(name: Notification.Name("PasswordlessEmailNotificationSuccess")))
        }
      }
    }

    // MARK: - Private Helpers

    private func configureControllers() {
      authNavController.configureTabBar(
        title: "Authentication",
        systemImageName: "person.crop.circle.fill.badge.plus"
      )
      userNavController.configureTabBar(title: "Current User", systemImageName: "person.fill")
      tabBarController.viewControllers = [authNavController, userNavController]
    }

}
