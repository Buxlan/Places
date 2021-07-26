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

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // swiftlint:disable:next unused_optional_binding
        guard let _ = (scene as? UIWindowScene) else { return }
        
        window?.tintColor = Asset.other0.color

    }

}
