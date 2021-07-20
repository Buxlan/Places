//
//  OnboardingCoordinator.swift
//  Places
//
//  Created by  Buxlan on 7/19/21.
//

import Foundation

class OnboardingCoordinator: Any {
    
    weak var parentViewController: OnboardingViewController?
    
    @objc
    func dismiss() {
        AppController.shared.isFirstLaunch = false
        parentViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func futher() {
        if let pvc = parentViewController {
            let currentIndex = pvc.currentIndex
            pvc.nextPage(viewControllerBefore: pvc.items[currentIndex])
        }
    }
    
    @objc
    func signUp() {
        
        print("Sign up")
        
    }
    
    @objc
    func signIn() {
        
        let vc = SignInViewController()
        parentViewController?.present(vc, animated: true)
        
    }
    
}
