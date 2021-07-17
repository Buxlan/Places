//
//  NearestPlacesViewController.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import UIKit

class NearestPlacesViewController: UIViewController {
    
    // MARK: - Public
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.title
        configureBars()
    }
        
    // MARK: - Private
    private struct Strings {
        static let title: String = "На карте"
    }
    
    private func configureBars() {
        navigationController?.title = title
        navigationController?.isToolbarHidden = true
        navigationController?.hidesBarsOnTap = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}
