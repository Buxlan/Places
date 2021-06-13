//
//  FavoritePlacesViewController.swift
//  Places
//
//  Created by  Buxlan on 5/26/21.
//

import UIKit

class FavoritePlacesViewController: UIViewController {
    
    // MARK: - Public
    
    // MARK: - Private
    
    struct Strings {
        static let title = "Избранное"
        static let cellReuseId = "PlaceCell"
    }
    
    var dataSource: [Place]?
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero
                                    , style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Events and actions
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if let _ = self.title {
            //
        } else {
            self.title = Strings.title
        }
        
        configureBars()
        
    }
    
    private func configureBars() {
    
        if let _ = navigationController?.title {
            //
        } else {
            navigationController?.title = title
        }
        navigationController?.hidesBarsOnTap = false
        navigationController?.isToolbarHidden = true
        
        
        
    }
    
}

extension FavoritePlacesViewController: UITableViewDelegate {
    
    
}

extension FavoritePlacesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.cellReuseId, for: indexPath)
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
