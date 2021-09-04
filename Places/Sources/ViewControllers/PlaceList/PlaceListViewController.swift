//
//  PlaceListTableViewController.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import UIKit

class PlaceListViewController: UITableViewController {
    
    // MARK: - Properties
    private static let cellReuseIdentifier = String.init(describing: PlaceListViewController.self)
    
    private lazy var viewModel: PlaceListViewModel = PlaceListViewModel()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .white)
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var categoriesCollectionView: UICollectionView = {
        let backgroundColor = Asset.other2.color
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = backgroundColor
        view.isUserInteractionEnabled = true
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        view.register(PlaceCategoryCell.self,
                      forCellWithReuseIdentifier: PlaceCategoryCell.reuseIdentifier)
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
        configureInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureBars()
    }
    
    // MARK: - Helper Functions
    private func configureInterface() {
        title = L10n.PlacesList.title
        view.tintColor = Asset.other0.color
        view.backgroundColor = Asset.other1.color
        configureTableView()
    }
    
    private func configureTableView() {
        guard let tableView = view as? UITableView else {
            return
        }
        tableView.isUserInteractionEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.allowsSelectionDuringEditing = false
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(PlaceListCell.self,
                           forCellReuseIdentifier: PlaceListCellConfigurator.reuseIdentifier)
                
        tableView.tableFooterView = UIView()
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc
    private func selectCategory(_ sender: UIButton) {       
        let indexPath = IndexPath(row: 0, section: sender.tag)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    @objc
    private func addReviewAction(_ sender: UIButton) {
        let vc = NewReviewViewController()
        vc.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(vc, animated: true)
    }
 
    // MARK: - Table view delegate and datasource
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.item(at: indexPath)
        let vc = ReviewListViewController(data: item)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(vc, animated: true)
    }    
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return viewModel.items(at: section).count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.tableViewSections[indexPath.section].items[indexPath.row]
                
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceListCellConfigurator.reuseIdentifier,
                                                 for: indexPath)
        
        if let castedCell = cell as? PlaceListCell,
           castedCell.isInterfaceConfigured == false {
            let options = ConfigurableCellInputOptions(collectionViewDelegate: self,
                                                       collectionViewDataSource: self,
                                                       indexPath: indexPath)
            item.configureInterface(cell: cell, with: options)
        }
        item.configure(cell: cell)
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.tableViewSections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.tableViewSections[section].name
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PlaceListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollectionView {
            let tableIndexPath = IndexPath(row: 0, section: indexPath.row)
            tableView.scrollToRow(at: tableIndexPath, at: .top, animated: true)
        } else {
            let review = Review.empty
            let vc = UIViewController.instantiateViewController(withIdentifier: .review)
            if let vc = vc as? ReviewViewController {
                vc.review = review
                vc.modalTransitionStyle = .flipHorizontal
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.tableViewSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionCell.reuseIdentifier,
                                                      for: indexPath)
        
        guard let castedCell = cell as? ReviewCollectionCell else {
            return cell
        }
        
        let currentIndexPath = IndexPath(row: 0, section: 0)
        let options = ConfigurableCellInputOptions(collectionViewDelegate: nil,
                                                   collectionViewDataSource: nil,
                                                   indexPath: indexPath)
        castedCell.configureInterface(with: options)
        
//        let section = tableView.
//        let item = viewModel.sections[section.].items[indexPath.row]
//        let title = section.name ?? ""
        let data = Review.empty
        castedCell.configure(data: data)
        
        return cell
    }
    
}

extension PlaceListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesCollectionView {
            return CGSize(width: 80, height: 100)
        } else {
            let itemsPerRow: CGFloat = 1
            let paddingWidth = 20 * (itemsPerRow + 1)
            let availableWidth = collectionView.frame.width - paddingWidth
            let itemWidth = availableWidth / itemsPerRow
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoriesCollectionView {
            return .zero
        } else {
            return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoriesCollectionView {
            return 8
        } else {
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoriesCollectionView {
            return 8
        } else {
            return 20
        }
    }

}
