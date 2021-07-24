//
//  FavoritePlacesViewController.swift
//  Places
//
//  Created by  Buxlan on 5/26/21.
//

import UIKit

class FavoritePlacesViewController: UIViewController {
    
    init() {
        viewModel = FavoritePlacesViewModel(tableView: tableView)
        super.init(nibName: nil, bundle: nil)
        
        // Tab bar configure
        tabBarItem.title = L10n.FavoritePlaces.title
        let image = Asset.favoriteFill.image.resizeImage(to: 30, aspectRatio: .current, with: view.tintColor)
        tabBarItem.image = image
    }
    
    // MARK: - Public
    struct Strings {
        static let title = "Избранное"
        static let cellReuseId = "PlaceCell"
    }
    
    // MARK: - Private
    private var tableView: UITableView = UITableView(frame: .zero, style: .plain)
    private var viewModel: FavoritePlacesViewModel
    private var spinner = UIActivityIndicatorView(style: .gray)
    
    // MARK: - Init, Events and actions
    required init?(coder: NSCoder) {
        viewModel = FavoritePlacesViewModel(tableView: tableView)
        super.init(coder: coder)        
    }
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = Asset.background0.color
       
        tableView.tableFooterView = UIView()
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
            spinner.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
   
        if self.title != nil {
            //
        } else {
            self.title = Strings.title
        }
        
        configureBars()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // update data
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        viewModel.updateData { [weak spinner] in
            spinner?.stopAnimating()
        }
    }
    
    private func configureBars() {
    
        if navigationController?.title != nil {
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
       
        // cell configure
        // end cell configure
        
        return cell
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
