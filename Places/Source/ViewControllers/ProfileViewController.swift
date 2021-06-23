//
//  ProfileViewController.swift
//  Places
//
//  Created by  Buxlan on 5/28/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Public vars and properties
    
    // MARK: - Public functions
    
    // MARK: - UI Elements
    private struct Strings {
        static let title = "Profile"
    }
    
    // MARK: - Events and actions
    
    override func viewDidLoad() {
        
        title = Strings.title
        
        view.backgroundColor = .bxBackground
        Utils.log("Did load", object: self)
        
        super.viewDidLoad()
        
    }
    
    // MARK: Other private vars, properties and methods
    private var login: String? {
        didSet {
            // firstViewResponder = Password view
        }
    }
    private var password: String? {
        didSet {
            
        }
    }
    
}
