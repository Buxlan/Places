//
//  ImageViewController.swift
//  Places
//
//  Created by  Buxlan on 8/2/21.
//

import UIKit

class ImageViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureBars()
    }
    
    // MARK: - Helper functions
    private func configureBars() {
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = Asset.other1.color
        navigationController?.navigationBar.tintColor = Asset.other0.color
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    private func configureInterface() {
        view.backgroundColor = Asset.accent0.color
        configureConstraints()
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [

        ]
        NSLayoutConstraint.activate(constraints)
    }

}
