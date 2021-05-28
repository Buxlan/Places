//
//  OnboardingThirdViewController.swift
//  Places
//
//  Created by  Buxlan on 5/27/21.
//

import UIKit

class OnboardingThirdViewController: UIViewController {
    
    lazy var nextButtonAction = UIAction() { action in
        guard let parent = self.parent as? OnboardingViewController else {
            fatalError()
        }
        parent.nextPage(viewControllerBefore: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        let button = UIButton.onboardingButton(title: "Начать без регистрации", image: nil, action: nextButtonAction)
        view.addSubview(button)
        
        let constraints: [NSLayoutConstraint] = [
            button.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -25),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    deinit {
        Utils.log("deinit OnboardingThirdViewController", object: self)
    }
    
}
