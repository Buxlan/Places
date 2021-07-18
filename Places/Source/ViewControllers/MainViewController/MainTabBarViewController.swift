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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
            
        delegate = self
        setViewControllers(items, animated: true)
        selectedIndex = 0
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if AppController.shared.isFirstLaunch {
            let vc: UIViewController = .instantiateViewController(withIdentifier: .onboarding)
            present(vc, animated: true, completion: nil)
        }
                       
        guard let tabBarItems = tabBar.items,
              let firstItem = tabBarItems.first
        else {
            Log(text: "tab bar is empty", object: self)
            fatalError()
        }
        self.tabBar(self.tabBar, didSelect: firstItem)
    }
    
    // MARK: - Private vars and functions
    
    private let appController = AppController.shared
    
    private lazy var items: [UIViewController] = [
        UINavigationController(rootViewController: appController.viewController(.placeList)),
        UINavigationController(rootViewController: appController.viewController(.nearestPlaces)),
        UINavigationController(rootViewController: appController.viewController(.favorites)),
        UINavigationController(rootViewController: appController.viewController(.profile))
    ]
    
    @objc
    private func presentViewController(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let viewControllerIdentifier
                = userInfo["viewControllerIdentifier"] as? AppController.ViewControllerIdentifier else {
            Log(text: "Error: Problems while presenting view controller")
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
    private func obnoardingDismissed() {
        Log(text: "onboarding dismissed", object: self)
        appController.isFirstLaunch = false
    }
    
    private var swipeDirection: UISwipeGestureRecognizer.Direction?
    
    @objc
    private func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        swipeDirection = sender.direction
        if sender.direction == .left {
            if selectedIndex < items.count - 1 {
                let vc = items[selectedIndex + 1]
                _ = self.tabBarController(self, shouldSelect: vc)
            }
        } else if sender.direction == .right {
            if selectedIndex > 0 {
                let vc = items[self.selectedIndex - 1]
                _ = self.tabBarController(self, shouldSelect: vc)
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func configureViewController(vc: UIViewController) -> UIViewController {
               
              
        vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.bxSecondaryText],
            for: .normal)
        
        vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.bxDarkText],
            for: .selected)
        
        return vc
    }
    
    private struct Constants {
        static let tabBarItemNames = ["Панорама".localized(),
                                      "На карте".localized(),
                                      FavoritePlacesViewController.Strings.title.localized(),
                                      "Профиль".localized()]
    }
    
}
// UITabBarControllerDelegate
extension MainTabBarViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let numberOfItems = items.count
        let tabBarItemSize = CGSize(width: tabBar.frame.width / CGFloat(numberOfItems), height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor.bxBackground,
                                                                size: tabBarItemSize)
        
//        tabBar.frame.size.width = self.view.frame.width + 4
//        tabBar.frame.origin.x = -2
 
        tabBar.barTintColor = UIColor.bxBackground
    }
    
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        
        guard let fromView = selectedViewController?.view,
              let toView = viewController.view else {
            return false
        }
        
        if fromView != toView {
            let transitionStyle = UIView.AnimationOptions.transitionCrossDissolve
            UIView.transition(from: fromView,
                              to: toView,
                              duration: 0.5,
                              options: [transitionStyle],
                              completion: nil)
        }
        selectedViewController = viewController
        
        return true
    }
}
