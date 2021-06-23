//
//  Onboarding.swift
//  Places
//
//  Created by  Buxlan on 5/6/21.
//

import UIKit
import UserNotifications

@objc
protocol OnboardingViewControllerDelegate: AnyObject {
    
    @objc
    func buttonFutherTapped()
    
    @objc
    func dismissTapped()
    
}

class OnboardingViewController: UIPageViewController {
    
    // MARK: - Public
    
    // MARK: - Private
    
    private var currentIndex = 0
    private var items = [UIViewController]() {
        didSet {
            for item in items {
                if var vc = item as? OnboardingProtocol {
                    vc.rootViewController = self
                }
            }
        }
    }
    
    private let appSettings = AppController.shared.settings
        
    private lazy var dismissAction: () -> Void = { [weak self] in
        self?.dismiss(animated: true) {
            Utils.log("Dismissed", object: self)
        }
    }
    
    // MARK: - initializers
    
    // MARK: - events and actions
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        items = [
            .instantiateViewController(withIdentifier: .onboarding1),
            .instantiateViewController(withIdentifier: .onboarding2),
            .instantiateViewController(withIdentifier: .onboarding3)
        ]
        
        setViewControllers([items[0]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
    
    func nextPage(viewControllerBefore viewController: UIViewController) {
        guard let index = items.firstIndex(of: viewController) else { fatalError() }
        if index == items.count - 1 {
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: .onboardingDismiss, object: nil)
            }
            currentIndex = 0
            return
        } else {
            currentIndex = index+1
            setViewControllers([items[index+1]],
                               direction: .forward,
                               animated: true) { _ in
                viewController.dismiss(animated: false, completion: nil)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("viewControllerBefore")
        guard let index = items.firstIndex(of: viewController) else {
            fatalError()
        }
        return (index == 0 ? nil : items[index-1])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("viewControllerAfter")
        guard let index = items.firstIndex(of: viewController) else {
            fatalError()
        }
        return (index == (items.count-1) ? nil : items[index+1])
    }
    
}

extension OnboardingViewController: UIPageViewControllerDelegate {
           
}

extension OnboardingViewController: OnboardingViewControllerDelegate {
    @objc
    func buttonFutherTapped() {
        self.nextPage(viewControllerBefore: self.items[self.currentIndex])
    }
    
    @objc
    func dismissTapped() {
        dismiss(animated: true) {
            Utils.log("Dismissed", object: self)
        }
    }
}
