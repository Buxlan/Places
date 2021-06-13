//
//  AuthLoginViewController.swift
//  Places
//
//  Created by  Buxlan on 5/28/21.
//

import UIKit

class AuthLoginViewController: UIViewController {
    
    // MARK: - Public vars and properties
    
    // MARK: - UI Elements
    struct Strings {
        static let title = "Login"
    }
    
    // MARK: - Events and actions
    
    override func viewDidLoad() {
        
        title = Strings.title
        
        view.backgroundColor = .bxOrdinaryBackground
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
