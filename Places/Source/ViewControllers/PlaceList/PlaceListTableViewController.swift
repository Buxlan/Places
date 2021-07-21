//
//  PlaceListTableViewController.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import UIKit

class PlaceListTableViewController: UITableViewController {
    
    // MARK: - Public
    struct Strings {
        static let cellReuseId = "PlaceCell"
    }
    
    // MARK: - Private
    private var dataSource: PlaceListDataModel = PlaceListDataModel()
    private var viewModel: PlaceListViewModel = PlaceListViewModel()
    private var spinner = UIActivityIndicatorView(style: .white)
    
    // MARK: - Init, Events and actions
    init() {
        super.init(nibName: nil, bundle: nil)
        tableView = UITableView(frame: .zero, style: .grouped)
        configureTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTabBarItem()
    }
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = Asset.background.color
        title = L10n.PlacesList.title
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(spinner)
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: Strings.cellReuseId)
        
        tableView.tableFooterView = UIView()
//        tableView.register(PlaceTableViewFooter.self, forHeaderFooterViewReuseIdentifier: PlaceTableViewFooter.reuseIdentifier)
        
        let constraints: [NSLayoutConstraint] = [
//            tableView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
//            tableView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
//            tableView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
//            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
           
        configureBars()
        
    }
    
    private func configureTabBarItem() {
        tabBarItem.title = L10n.PlacesList.title
        let image = Asset.buildingColumns.image.resizeImage(to: 30, aspectRatio: .current)
        tabBarItem.image = image
        title = L10n.App.name
    }
    
    private func configureBars() {
    
        navigationController?.title = title
        navigationController?.hidesBarsOnTap = false
        navigationController?.isToolbarHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // update data
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        viewModel.updateData { [weak spinner] in
            DispatchQueue.main.async {
                spinner?.stopAnimating()
            }
        }
    }
    
    @objc
    private func updateData() {
        spinner.startAnimating()
        viewModel.updateData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
    //            self?.viewModel.database.goOnline()
                self?.spinner.stopAnimating()
            }
        }
    }
    
}

// Delegate
extension PlaceListTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return self.tableView.bounds.height / 2
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return nil
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 50
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
//        return 50
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: PlaceTableViewFooter.reuseIdentifier)
//        return view
//    }

}

// Data source
extension PlaceListTableViewController {

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return dataSource.items(in: section).count
    }
    
    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.items[indexPath.row]
                
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.cellReuseId, for: indexPath)
        
        // configure cell
        
        // end configure
        
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sections.count
    }
    
}
