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
    
    private var tableView: UITableView = UITableView(frame: .zero, style: .plain)
    private var viewModel: FavoritePlacesViewModel
    private var spinner = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Init, Events and actions
    required init?(coder: NSCoder) {
        viewModel = FavoritePlacesViewModel(tableView: tableView)
        
        // update data
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        viewModel.updateData { [weak spinner] in
            spinner?.stopAnimating()
        }
        super.init(coder: coder)        
    }
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .bxOrdinaryBackground
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(spinner)
        tableView.register(FavoritePlaceTableViewCell.self, forCellReuseIdentifier: Strings.cellReuseId)
        
        let constraints: [NSLayoutConstraint] = [
            tableView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
   
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.bounds.height / 5
    }
}

extension FavoritePlacesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.items[indexPath.row]
                
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.cellReuseId, for: indexPath)
        
        let configuration = FavoritePlaceCellConfiguration(place: item)
        cell.contentConfiguration = configuration
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
