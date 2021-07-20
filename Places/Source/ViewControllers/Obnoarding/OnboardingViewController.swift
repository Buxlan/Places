//
//  Onboarding.swift
//  Places
//
//  Created by  Buxlan on 5/6/21.
//

import UIKit
import UserNotifications

protocol OnboardingViewControllerProtocol: AnyObject {
    var coordinator: OnboardingCoordinator { get set }
}

class OnboardingViewController: UIPageViewController,
                                OnboardingViewControllerProtocol {
    
    // MARK: - Public
    var currentIndex = 0
    
    init() {
        let options = [UIPageViewController.OptionsKey.interPageSpacing: 32]
        coordinator = OnboardingCoordinator()
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: options)
        coordinator.parentViewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var items: [UIViewController] = {
        let firstOnboardingVC = OnboardingFirstViewController(coordinator: self.coordinator)
        let secondOnboardingVC = OnboardingSecondViewController(coordinator: self.coordinator)
        let thirdOnboardingVC = OnboardingThirdViewController(coordinator: self.coordinator)
        let  items = [firstOnboardingVC, secondOnboardingVC, thirdOnboardingVC]
        return items
    }()
    
    // MARK: - Private
    internal var coordinator: OnboardingCoordinator
        
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
        
        setViewControllers([items[0]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
    
    func nextPage(viewControllerBefore viewController: UIViewController) {
        guard let index = items.firstIndex(of: viewController)
        else {
            fatalError()
        }
        
        if index == items.count - 1 {
            AppController.shared.isFirstLaunch = false
            coordinator.dismiss()
            return
        } else {
            currentIndex = index+1
            setViewControllers([items[index+1]],
                               direction: .forward,
                               animated: true) { _ in
//                viewController.dismiss(animated: false, completion: nil)
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
        return nil
//        print("viewControllerBefore")
//        guard let index = items.firstIndex(of: viewController) else {
//            fatalError()
//        }
//        return (index == 0 ? nil : items[index-1])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("viewControllerAfter")
        guard let index = items.firstIndex(of: viewController) else {
            fatalError()
        }
        return (index == (items.count-1) ? nil : items[index+1])
    }
    
}
