//
//  Onboarding.swift
//  Places
//
//  Created by  Buxlan on 5/6/21.
//

import UIKit
import UserNotifications

class OnboardingViewController: UIPageViewController {
    
    let appSettings = AppController.shared.settings
    
    lazy var items: [UIViewController] = [
        .instantiateViewController(withIdentifier: .onboarding1),
        .instantiateViewController(withIdentifier: .onboarding2),
        .instantiateViewController(withIdentifier: .onboarding3)
    ]
    
    private var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        setViewControllers([items[0]], direction: .forward, animated: true, completion: { success in
            print("view controllers was setted")
        })
    }
    
    func nextPage(viewControllerBefore viewController: UIViewController) {
        guard let index = items.firstIndex(of: viewController) else { fatalError() }
        if index == items.count - 1 {
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: .onboardingDismiss, object: nil)
            }
            return
        } else {
            setViewControllers([items[index+1]], direction: .forward, animated: true) { (success) in
                viewController.dismiss(animated: false) {
                }
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
