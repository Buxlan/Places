//
//  ReviewListViewController.swift
//  Places
//
//  Created by  Buxlan on 7/26/21.
//

import UIKit

class ReviewListViewController: UIViewController {
    
    // MARK: - Public
        
    // MARK: - Private
    private var data: Place {
        didSet {
            viewModel.update()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
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
        data = Place.empty
        super.init(nibName: nil, bundle: nil)
        configureTabBarItem()
        configureBars()
    }
    
    convenience init(data: Place) {
        self.init()
        self.data = data
    }
    
    required init?(coder: NSCoder) {
        data = Place.empty
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
        let image = Asset.buildingColumns.image.resizeImage(to: 24,
                                                            aspectRatio: .current,
                                                            with: view.tintColor)
        tabBarItem.image = image
        let selImage = Asset.buildingColumnsFill.image.resizeImage(to: 26,
                                                                   aspectRatio: .current,
                                                                   with: view.tintColor)
        tabBarItem.selectedImage = selImage
        title = L10n.App.name
    }
    
    private func configureBars() {
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// Delegate
extension ReviewListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.item(at: indexPath)
        if let vc = UIViewController.instantiateViewController(withIdentifier: .place) as? PlaceViewController {
            vc.place = item
            vc.modalPresentationStyle = .pageSheet
            present(vc, animated: true)
        }
    }
    
}
