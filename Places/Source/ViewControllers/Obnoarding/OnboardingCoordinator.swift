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
    func dismissTapped() {
        AppController.shared.isFirstLaunch = false
        parentViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func futherTapped() {
        if let pvc = parentViewController {
            let currentIndex = pvc.currentIndex
            pvc.nextPage(viewControllerBefore: pvc.items[currentIndex])
        }
    }
    
}
