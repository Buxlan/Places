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
    private var swipeDirection: UISwipeGestureRecognizer.Direction?
    
    // MARK: - Public functions
    required init?(coder: NSCoder) {
        super.init(coder: coder)        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.tintColor = Asset.other0.color
        title = L10n.App.name
            
        delegate = self
        setViewControllers(items, animated: true)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
        self.navigationController?.isNavigationBarHidden = true
                
        // remove default border
        tabBar.frame.size.width = self.view.frame.width + 4
        tabBar.frame.origin.x = -2
        
        UITabBar.appearance().tintColor = Asset.other0.color
        selectedIndex = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
             
        if AppController.shared.isFirstLaunch {
            let onboarding: UIViewController = OnboardingPageViewController()
            onboarding.modalPresentationStyle = .fullScreen
            present(onboarding, animated: true, completion: nil)
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
    
    private lazy var items: [UIViewController] = {
        var items = [UIViewController]()
        var vc: UINavigationController
        vc = UINavigationController(rootViewController: PlaceListViewController())
        vc.isToolbarHidden = true
        vc.hidesBarsOnTap = false
        vc.isToolbarHidden = true
        vc.hidesBarsWhenKeyboardAppears = true
        vc.setNavigationBarHidden(true, animated: false)
        items.append(vc)
        
        vc = UINavigationController(rootViewController: AuthorListViewController())
        vc.isToolbarHidden = true
        vc.hidesBarsOnTap = false
        vc.isToolbarHidden = true
        vc.hidesBarsWhenKeyboardAppears = true
        vc.setNavigationBarHidden(true, animated: false)
        items.append(vc)
        
        vc = UINavigationController(rootViewController: FavoritePlacesViewController())
        vc.isToolbarHidden = true
        vc.hidesBarsOnTap = false
        vc.isToolbarHidden = true
        vc.hidesBarsWhenKeyboardAppears = true
        vc.setNavigationBarHidden(true, animated: false)
        items.append(vc)
        
        vc = UINavigationController(rootViewController: ProfileViewController())
        vc.isToolbarHidden = true
        vc.hidesBarsOnTap = false
        vc.isToolbarHidden = true
        vc.hidesBarsWhenKeyboardAppears = true
        vc.setNavigationBarHidden(true, animated: false)
        items.append(vc)
        return items
    }()
    
    @objc
    private func obnoardingDismissed() {
        Log(text: "onboarding dismissed", object: self)
        appController.isFirstLaunch = false
    }
    
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
    
}
// UITabBarControllerDelegate
extension MainTabBarViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        let numberOfItems = items.count
//        let tabBarItemSize = CGSize(width: tabBar.frame.width / CGFloat(numberOfItems), height: tabBar.frame.height)
//        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: Asset.background0.color,
//                                                                size: tabBarItemSize)
        
//        clearTabBarSelectionColor()
//        setTabBarSelectionColor(item: item)
        
        tabBar.frame.size.width = self.view.frame.width + 4
        tabBar.frame.origin.x = -2
        
        let numberOfItems = CGFloat(items.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems,
                                    height: tabBar.frame.height)
        let color = Asset.other1.color
        
        let image = UIImage.imageWithColor(color: color,
                                           size: tabBarItemSize)
        let resImage = image.resizableImage(withCapInsets: UIEdgeInsets.zero)
        tabBar.selectionIndicatorImage = resImage
        
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
