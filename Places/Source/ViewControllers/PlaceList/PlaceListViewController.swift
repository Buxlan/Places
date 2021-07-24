//
//  PlaceListTableViewController.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import UIKit

class PlaceListViewController: UIViewController {
    
    // MARK: - Public
        
    // MARK: - Private
    private var viewModel: PlaceListViewModel = PlaceListViewModel()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .white)
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView  = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.delegate = self
        view.dataSource = viewModel
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension        
        view.register(PlaceListCell.self,
                           forCellReuseIdentifier: PlaceListCell.reuseIdentifier)
        
        view.tableFooterView = UIView()
        return view
    }()
    
    // MARK: - Init, Events and actions
    init() {
        super.init(nibName: nil, bundle: nil)
        configureTabBarItem()
        configureBars()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTabBarItem()
        configureBars()
    }
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        title = L10n.PlacesList.title
        
        view.addSubview(tableView)
        view.addSubview(spinner)
        
        view.tintColor = Asset.foreground0.color
        view.backgroundColor = Asset.background0.color

        configureConstraints()
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // update data
        
//        spinner.startAnimating()
//        dataSource.updateData { [weak spinner] in
//            DispatchQueue.main.async {
//                spinner?.stopAnimating()
//            }
//        }
//        print(view.tintColor)
    }
    
    private func configureTabBarItem() {
        tabBarItem.title = L10n.PlacesList.title
        let image = Asset.buildingColumns.image.resizeImage(to: 30,
                                                            aspectRatio: .current,
                                                            with: view.tintColor)
        tabBarItem.image = image
        title = L10n.App.name
    }
    
    private func configureBars() {
        navigationController?.title = title
        navigationController?.hidesBarsOnTap = false
        navigationController?.isToolbarHidden = true
    }
    
//    @objc
//    private func updateData() {
//        spinner.startAnimating()
//        dataSource.updateData { [weak self] in
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//    //            self?.viewModel.database.goOnline()
//                self?.spinner.stopAnimating()
//            }
//        }
//    }
    
}

// Delegate
extension PlaceListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.item(at: indexPath)
        if let vc = UIViewController.instantiateViewController(withIdentifier: .place) as? PlaceViewController {
            vc.place = item
            vc.modalPresentationStyle = .pageSheet
            present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
