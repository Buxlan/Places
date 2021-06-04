//
//  FavoritePlacesViewController.swift
//  Places
//
//  Created by  Buxlan on 5/26/21.
//

import UIKit

class FavoritePlacesViewController: UIViewController {
    
    // MARK: - Public vars and properties
    
    // MARK: - Public functions
    
    // MARK: - UI Elements
    private struct Strings {
        static let title = "Favorites"
    }
    
    // MARK: - Events and actions
    
    override func viewDidLoad() {
        
        title = Strings.title
        
        super.viewDidLoad()
        
    }
    
}
