//
//  PlaceListTableViewController.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import UIKit

class PlaceListViewController: UIViewController {
    
    // MARK: - Properties
    private static let cellReuseIdentifier = String.init(describing: PlaceListViewController.self)
    
    private lazy var viewModel: PlaceListViewModel = {
        let item = PlaceListViewModel()
        item.managedViewController = self
        return item
    }()
    
    private lazy var addReviewButton: UIButton = {
        let backgroundColor = Asset.other2.color
        let tintColor = Asset.other0.color
        let view = UIButton()
        view.addTarget(self, action: #selector(addReviewAction), for: .touchUpInside)
//        view.layer.borderWidth = 0.5
//        view.layer.borderColor = Asset.other0.color.cgColor
        view.setImage(Asset.plus.image.resizeImage(to: 37,
                                                   aspectRatio: .square,
                                                   with: backgroundColor), for: .normal)
        view.setImage(Asset.plusFill.image.resizeImage(to: 37,
                                                         aspectRatio: .square,
                                                         with: backgroundColor), for: .selected)
//        view.contentEdgeInsets = .init(top: 10, left: 6, bottom: 10, right: 6)
//            button.tintColor = Asset.other0.color
//        view.layer.cornerRadius = 4
//        view.layer.masksToBounds = true
        view.imageView?.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoLabel: UILabel = {
        let view = UILabel()
        let text = L10n.App.name
        let attr: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attrStr = NSAttributedString(string: text, attributes: attr)
        view.attributedText = attrStr
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = .bxControlTitle
        return view
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .white)
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stack: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 8
                
        for (index, section) in viewModel.sections.enumerated() {
            let button = UIButton()
            button.setTitle(section.name, for: .normal)
            button.tag = index
            button.titleLabel?.font = .regularFont12
            button.addTarget(self, action: #selector(selectCategory), for: .touchUpInside)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = Asset.other0.color.cgColor
            button.backgroundColor = Asset.accent1.color
            button.setTitleColor(Asset.other2.color, for: .normal)
            button.contentEdgeInsets = .init(top: 10, left: 6, bottom: 10, right: 6)
//            button.tintColor = Asset.other0.color
            button.layer.cornerRadius = 4
            button.clipsToBounds = true
            view.addArrangedSubview(button)
        }
        
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
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
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
        
        view.addSubview(logoLabel)
        view.addSubview(categoriesCollectionView)
        view.addSubview(addReviewButton)
        view.addSubview(scrollView)
        view.addSubview(tableView)
        view.addSubview(spinner)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            logoLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                           constant: 8),
            logoLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            addReviewButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            addReviewButton.topAnchor.constraint(equalTo: logoLabel.topAnchor),
            addReviewButton.widthAnchor.constraint(equalTo: logoLabel.heightAnchor),
            addReviewButton.heightAnchor.constraint(equalTo: logoLabel.heightAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 4),
            scrollView.heightAnchor.constraint(equalToConstant: 40),
            
            stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stack.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
            stack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stack.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            tableView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 100),
            categoriesCollectionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8)
            
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
    
}

// Delegate
extension PlaceListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.item(at: indexPath)
        let vc = ReviewListViewController(data: item)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PlaceListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCategoryCell.reuseIdentifier,
                                                      for: indexPath)
        
        if let cell = cell as? PlaceCategoryCell {
            cell.configureInterface()
            let section = viewModel.sections[indexPath.row]
            let title = section.name ?? ""
            let data = PlaceCategory(title: title, image: section.icon)
            cell.configure(data: data)
        }
        cell.backgroundColor = .blue
        
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

extension PlaceListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.items(at: section).count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
                
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceListCellConfigurator.reuseIdentifier,
                                                 for: indexPath)
        
        if let castedCell = cell as? PlaceListCell,
           castedCell.isInterfaceConfigured == false {
            let options = [PlaceListCell.Option.collectionDelegate.rawValue: self,
                           PlaceListCell.Option.collectionDataSource.rawValue: self]
            item.configureInterface(cell: cell, with: options)
        }
        item.configure(cell: cell)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].name
    }
        
}
