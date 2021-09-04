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
    private var viewModel: FavoritePlacesViewModel = FavoritePlacesViewModel()
    
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
        view.register(FavoritePlaceCell.self,
                           forCellReuseIdentifier: FavoritePlaceCell.reuseIdentifier)
        
        view.tableFooterView = UIView()
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
        
        view.tintColor = Asset.other0.color
        view.backgroundColor = Asset.other1.color

        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureBars()
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
    
    private func configureTabBarItem() {
        tabBarItem.title = L10n.PlacesList.title
        let image = Asset.favorite.image.resizeImage(to: 24,
                                                     aspectRatio: .current,
                                                     with: view.tintColor)
        tabBarItem.image = image
        let selImage = Asset.fillFavorite.image.resizeImage(to: 26,
                                                            aspectRatio: .current,
                                                            with: view.tintColor)
        tabBarItem.selectedImage = selImage
        title = L10n.App.name
    }
    
    private func configureBars() {
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

// Delegate
extension FavoritePlacesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.item(at: indexPath)
        let vc = ReviewListViewController(data: item)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
