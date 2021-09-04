//
//  AuthorList.swift
//  Places
//
//  Created by  Buxlan on 7/26/21.
//

import UIKit

class AuthorListViewController: UIViewController {
    
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
        view.dataSource = self
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
    
    private lazy var flexibleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Asset.main0.color
        return view
    }()
    
    // MARK: - Init, Events and actions
    init() {
        super.init(nibName: nil, bundle: nil)
        configureTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTabBarItem()
    }
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        title = L10n.PlacesList.title
        
        view.addSubview(tableView)
        view.addSubview(spinner)
        view.addSubview(flexibleView)
        
        view.tintColor = Asset.other0.color
        view.backgroundColor = Asset.other1.color

        configureConstraints()
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            flexibleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flexibleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            flexibleView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            flexibleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        let image = Asset.paintbrushPointedFill.image.resizeImage(to: 24,
                                                            aspectRatio: .current,
                                                            with: view.tintColor)
        tabBarItem.image = image
//        let selImage = Asset.buildingColumnsFill.image.resizeImage(to: 26,
//                                                                   aspectRatio: .current,
//                                                                   with: view.tintColor)
//        tabBarItem.selectedImage = selImage
        title = L10n.App.name
        
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
extension AuthorListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.item(at: indexPath)
        if let vc = UIViewController.instantiateViewController(withIdentifier: .place) as? PlaceViewController {
            vc.place = item
            vc.modalPresentationStyle = .pageSheet
            present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.items(at: section).count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.tableViewSections[indexPath.section].items[indexPath.row]
                
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceListCellConfigurator.reuseIdentifier,
                                                 for: indexPath)
        
        if let castedCell = cell as? PlaceListCell,
           castedCell.isInterfaceConfigured == false {
            var options = ConfigurableCellInputOptions()
            options.collectionViewDelegate = self
            options.collectionViewDataSource = self
            options.indexPath = indexPath
            item.configureInterface(cell: cell, with: options)
        }
        item.configure(cell: cell)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.tableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.tableViewSections[section].name
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension AuthorListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionCell.reuseIdentifier,
                                                      for: indexPath)
        return cell
    }
    
}
