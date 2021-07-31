//
//  NearestPlacesViewController.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import UIKit

class AuthorsListViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        // Tab bar configure
        tabBarItem.title = L10n.NearestPlaces.title
        let image = Asset.map.image.resizeImage(to: 30, aspectRatio: .current, with: view.tintColor)
        tabBarItem.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.title
    }
        
    // MARK: - Private
    private struct Strings {
        static let title: String = "На карте"
    }
    
}
