//
//  ViewController.swift
//  Places
//
//  Created by  Buxlan on 5/1/21.
//

import UIKit

class PlaceListViewController: UIViewController {
    
    // MARK: - Public vars and functions
    var dataSource: UICollectionViewDiffableDataSource<PlaceController.PlaceCollection, Place>! = nil
    
    override func viewDidLoad() {
        title = Strings.title
        configureNavigationBar()
        configureViewHierarchy()
        configureDataSource()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - Private vars and functions
    
    private struct Strings {
        static let title = "Панорама".localized()
        static let titleElementKind = "title_element-kind"
        static let heart = "heart"
        static let mostPopular = "Most popular places"
        
        static let imageName = "image"
        static let photoImageName = "photo"
    }
    
    private lazy var viewHierarchy: [UIView] = {
        var vh = [UIView]()
        vh.append(mostPopularCollectionView)
//        vh.append(mostPopularLabel)
//        vh.append(backgroundImageView)
        return vh
    }()
    
    private let placeController = PlaceController()
    private var currentSnapshot: NSDiffableDataSourceSnapshot<PlaceController.PlaceCollection, Place>! = nil
    
    private lazy var mostPopularCollectionView: UICollectionView = {
        var collectionsView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        collectionsView.backgroundColor = .systemBackground
        collectionsView.allowsSelection = true
        collectionsView.allowsMultipleSelection = false
        collectionsView.delegate = self
        return collectionsView
    }()
    
    private lazy var mostPopularLabel: UILabel = {
        let label = UILabel()
        label.font = .bxBody
        label.textColor = .bxSecondaryLabel
        label.text = Strings.mostPopular
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImage(systemName: Strings.photoImageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemPink
        imageView.sizeToFit()
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let font = UIFont.bxBody
        let config = UIImage.SymbolConfiguration(font: font, scale: UIImage.SymbolScale.medium)
        let image: UIImage = #imageLiteral(resourceName: "menuIcon")
        var item = UIBarButtonItem(title: Strings.imageName, style: .plain, target: self, action: #selector(rightNavigationItemPressed))
        item.image = image
        item.tintColor = .bxOrdinaryLabel
        
        return item
    }()
    
}

extension PlaceListViewController {
            
    @objc
    private func placeTapped(sender: Any?) {
        Log(text: "place tapped is not developed", object: self)
    }
    
}

/*
// MARK: - Collection view layout
*/
extension PlaceListViewController {
    func createLayout() -> UICollectionViewLayout {
        let sectionPrivider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // if we have the space, adapt and go 2-up + peeking 3rd item
            let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ? 0.425 : 0.85)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth), heightDimension: .absolute(300))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            
            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            
            let titleSuplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize, elementKind: Strings.titleElementKind, alignment: .top)
            section.boundarySupplementaryItems = [titleSuplementary]
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionPrivider, configuration: config)
        return layout
    }
}
    
/*
// MARK: - Other usefull functions
*/
extension PlaceListViewController {

    func configureViewHierarchy() {
        
        for v in viewHierarchy {
            self.view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mostPopularCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mostPopularCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mostPopularCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            mostPopularCollectionView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
        ])
    }
    
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<PlaceCollectionViewCell, Place> { (cell, indexPath, place) in
            // Populate the cell with our item description
            cell.titleLabel.text = place.title
            cell.categoryLabel.text = place.category
            cell.imageView.image = place.image
        }
        
        dataSource = UICollectionViewDiffableDataSource<PlaceController.PlaceCollection, Place>(collectionView: mostPopularCollectionView) { (collectionsView: UICollectionView, indexPath: IndexPath, place: Place) -> UICollectionViewCell? in
            // Return the cell
            return collectionsView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: place)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: Strings.titleElementKind) { (supplementaryView, string, indexPath) in
            if let snapshot = self.currentSnapshot {
                // Populate the view with our section's description
                let placeCategory = snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.label.text = placeCategory.title
                supplementaryView.label.textColor = .bxOrdinaryLabel
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.mostPopularCollectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
        
        currentSnapshot = NSDiffableDataSourceSnapshot<PlaceController.PlaceCollection, Place>()

        placeController.collections.forEach {
            let collection = $0
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.places)
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}
    
/*
// MARK: - Related to Navigation bar
*/
extension PlaceListViewController {

    func configureNavigationBar() {
        self.title = Strings.title
        navigationController?.title = Strings.title
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.barTintColor = .bxOrdinaryBackground

        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.bxOrdinaryLabel]

                
        navigationController?.hidesBarsOnTap = false
        navigationController?.isToolbarHidden = true               
                
    }
    
    // Actions
    @objc func rightNavigationItemPressed() {
        print("rightNavigationItemPressed actions")
    }

}

extension PlaceListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Log(text: "didSelectItemAt", object: collectionView)
        
        guard let item = dataSource.itemIdentifier(for: indexPath)
        else {
            fatalError()
        }
        
        let vc = UIViewController.instantiateViewController(withIdentifier: .place) as! PlaceViewController
        vc.place = item
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true)
    }
    
}

