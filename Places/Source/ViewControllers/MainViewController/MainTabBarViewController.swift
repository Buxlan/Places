//
//  TabBarViewController.swift
//  Places
//
//  Created by  Buxlan on 5/26/21.
//

import UIKit
import UserNotifications
import CoreGraphics

class MainTabBarViewController: UITabBarController {
    
    // MARK: - Public vars and properties
    
    // MARK: - Public functions
    
    // MARK: - Events and actions
    private let appController = AppController.shared
    
    private let symbolConfiguration: UIImage.SymbolConfiguration? = nil
    
    private lazy var items: [UIViewController] = [
        generateNavViewController(vc: appController.viewController(.placeList),
                                  image: UIImage(systemName: "building.columns")!
                                    .withTintColor(UIColor.bxFirstColor,
                                                   renderingMode: .alwaysOriginal)),
        generateNavViewController(vc: appController.viewController(.favorites),
                                  image: UIImage(systemName: "heart")!
                                    .withTintColor(UIColor.bxFirstColor,
                                                   renderingMode: .alwaysOriginal)),
        generateNavViewController(vc: appController.viewController(.profile),
                                  image: UIImage(systemName: "person")!
                                    .withTintColor(UIColor.bxFirstColor,
                                                   renderingMode: .alwaysOriginal))
    ]
    
    override func viewDidLoad() {
        
        Utils.log("tab bar did load", object: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changePage), name: .bxChangePage, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(obnoardingDismissed), name: .onboardingDismiss, object: nil)
        
        super.viewDidLoad()
        
        delegate = self
        setViewControllers(items, animated: true)      
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if AppController.shared.isFirstLaunch {
            let vc: UIViewController = .instantiateViewController(withIdentifier: .onboarding)
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc
    private func changePage(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let viewControllerIdentifier
                = userInfo["viewControllerIdentifier"] as? AppController.ViewControllerIdentifier else {
            fatalError()
        }
        
        if let presentedViewController = presentedViewController {
            presentedViewController.dismiss(animated: true) {
                [self, viewControllerIdentifier] in
                let viewController: UIViewController =
                    .instantiateViewController(withIdentifier: viewControllerIdentifier)
                present(viewController, animated: true) {
                    [weak viewController] in
                    Utils.log("completion of", object: viewController)
                }
            }
        }
        
        let viewController: UIViewController =
            .instantiateViewController(withIdentifier: viewControllerIdentifier)
        
        self.present(viewController, animated: true) {
            [weak viewController] in
            Utils.log("completion of", object: viewController)
        }
        
    }
    
    @objc
    func obnoardingDismissed() {
        Utils.log("onboarding dismissed", object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func generateNavViewController(vc: UIViewController, image: UIImage)  -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.title = vc.title
        navController.tabBarItem.title = vc.title
        navController.tabBarItem.image = image
        return navController
    }
    
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let numberOfItems = items.count
        let tabBarItemSize = CGSize(width: tabBar.frame.width / CGFloat(numberOfItems), height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor.bxSecondColor, size: tabBarItemSize)
        
        tabBar.frame.size.width = self.view.frame.width + 4
        tabBar.frame.origin.x = -2
    }
    
}

extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}
