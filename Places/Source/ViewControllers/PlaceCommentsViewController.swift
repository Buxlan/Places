//
//  PlaceCommentsViewController.swift
//  Places
//
//  Created by  Buxlan on 5/6/21.
//

import UIKit

class PlaceCommentsViewController: UIViewController {
    
    var placeController = PlaceController()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.allowsMultipleSelection = false
        tableView.allowsSelection = true
        tableView.delegate = self
        return tableView
    }()
    
    lazy var currentSnapshot: NSDiffableDataSourceSnapshot<PlaceController.PlaceCollection, Place> = {
        var snapshot = NSDiffableDataSourceSnapshot<PlaceController.PlaceCollection, Place>()
        placeController.collections.forEach {
            let collection = $0
            snapshot.appendSections([collection])
            snapshot.appendItems(collection.places)
        }
        return snapshot
    }()
    
    lazy var dataSource: UITableViewDiffableDataSource<PlaceController.PlaceCollection, Place> = {
        
        let dataSource = UITableViewDiffableDataSource<PlaceController.PlaceCollection, Place>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, itemIdentifier: Place) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlaceImageTableViewCell.self), for: indexPath) as? PlaceImageTableViewCell else { fatalError() }
            
            cell.configure(data: itemIdentifier)
            
            return cell
            
        }
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    func configure() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        configureNavigationBar()
        
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "Header")
        
        tableView.register(PlaceImageTableViewCell.self, forCellReuseIdentifier: String(describing: PlaceImageTableViewCell.self))
        
        dataSource.apply(currentSnapshot)
        tableView.reloadData()
    }
    
    func configureNavigationBar() {
        navigationController?.title = "Place"
        navigationController?.setNavigationBarHidden(false, animated: false)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right nav item", style: .plain, target: self, action: #selector(goBackButtonTapped))
    }
    
    @objc func goBackButtonTapped() {
        
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: { print("Went back") } )
        }
    }

}
