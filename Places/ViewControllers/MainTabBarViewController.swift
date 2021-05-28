//
//  TabBarViewController.swift
//  Places
//
//  Created by  Buxlan on 5/26/21.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    let appController = AppController.shared
    
    lazy var items: [UIViewController] = [
            appController.viewController(.placeList),
            appController.viewController(.favorites),
            appController.viewController(.profile)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers([items[0]], animated: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(obnoardingDismissed), name: .onboardingDismiss, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if AppController.shared.isFirstLaunch {
            let vc: UIViewController = .instantiateViewController(withIdentifier: .onboarding)
            present(vc, animated: true, completion: nil)
        }
    }
    
}

extension MainTabBarViewController {
    
    @objc
    func obnoardingDismissed() {
        
    }
    
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    
    
    
}
