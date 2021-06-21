//
//  PlaceListTableViewController.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import UIKit

class PlaceListTableViewController: UIViewController {
    
    // MARK: - Public
    struct Strings {
        static let title = "Лента"
        static let cellReuseId = "PlaceCell"
    }
    
    // MARK: - Private
    private var tableView: UITableView = UITableView(frame: .zero, style: .plain)
    private var viewModel: PlaceListViewModel
    private var spinner = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Init, Events and actions
    required init?(coder: NSCoder) {
        viewModel = PlaceListViewModel(tableView: tableView)
        
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done, target: self, action: #selector(updateData))
        
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
    
    @objc
    private func updateData() {
        spinner.startAnimating()
        viewModel.updateData { [weak self] in
//            self?.viewModel.database.goOnline()
            self?.spinner.stopAnimating()
        }
    }
    
    
}

extension PlaceListTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return self.tableView.bounds.height / 2
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
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

extension PlaceListTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.items[indexPath.row]
                
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.cellReuseId, for: indexPath)
        
        let configuration = PlaceCellConfiguration(place: item)
        cell.contentConfiguration = configuration
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
