//
//  SignUpViewController.swift
//  Places
//
//  Created by  Buxlan on 7/28/21.
//

import UIKit

class SignUpViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        configureBars()
    }

    private func configureBars() {
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
