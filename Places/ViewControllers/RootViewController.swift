//
//  ViewController.swift
//  Places
//
//  Created by  Buxlan on 5/1/21.
//

import UIKit

class RootViewController: UIViewController {

    /*
    // Vars
    */
    private lazy var viewHierarchy: [UIView] = {
        var vh = [UIView]()
        vh.append(collectionsView)
//        vh.append(mostPopularLabel)
//        vh.append(backgroundImageView)
        return vh
    }()
    
    lazy var rightBarButtonItem: UIBarButtonItem = {
        let font = UIFont.preferredFont(forTextStyle: .largeTitle)
        let config = UIImage.SymbolConfiguration(font: font, scale: UIImage.SymbolScale.medium)
        let image = UIImage(systemName: "heart.fill", withConfiguration: config)
        var item = UIBarButtonItem(title: "image", style: .plain, target: self, action: #selector(rightNavigationItemPressed))
        item.image = image
        item.tintColor = .systemRed
        
        print(String(describing: type(of: item)))
        
        return item
    }()
    
    let placesController = PlacesController()
    
    /*
    // Views
     */
    var collectionsView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<PlacesController.PlacesCollection, Place>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<PlacesController.PlacesCollection, Place>! = nil
    static let titleElementKind = "title_element-kind"
    
    lazy var mostPopularStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.addArrangedSubview(mostPopularLabel)
        stackView.addArrangedSubview(backgroundImageView)
        stackView.backgroundColor = .systemGray6
        
        print(stackView.subviews)
        
        return stackView
    }()
    
    lazy var mostPopularCollectionView: UICollectionView = {
        var collectionsView = UICollectionView()
        return collectionsView
    }()
    
    lazy var mostPopularLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Most popular places"
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let image = UIImage(systemName: "photo")
        let imageView = UIImageView(image: image)
        print("current content mode is \(imageView.contentMode.rawValue)")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemPink
        imageView.sizeToFit()
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    /*
    // Handling view controller events
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureViewHierarchy()
        configureDataSource()
    }
    
}
    
/*
// Handling controls actions
*/

extension RootViewController {
    
    func pushViewController() {
        let storyboard = UIStoryboard(name: "Place", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Place")
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func placeTapped(sender: Any?) {
        print("place tapped is not developed")
    }
    
}

/*
// Collection view layout
*/
extension RootViewController {
    func createLayout() -> UICollectionViewLayout {
        let sectionPrivider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // if we have the space, adapt and go 2-up + peeking 3rd item
            let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ? 0.425 : 0.85)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth), heightDimension: .absolute(250))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            
            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            
            let titleSuplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize, elementKind: RootViewController.titleElementKind, alignment: .top)
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
// Other usefull functions
*/
extension RootViewController {

    func configureViewHierarchy() {
        
        collectionsView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        collectionsView.layer.borderWidth = 2
        collectionsView.layer.borderColor = UIColor.black.cgColor
        
        for v in viewHierarchy {
            self.view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        collectionsView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            collectionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionsView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionsView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionsView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
        ])
    }
    
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<PlaceCollectionViewCell, Place> { (cell, indexPath, place) in
            // Populate the cell with our item description
            cell.titleLabel.text = place.title
            cell.categoryLabel.text = place.category
            cell.imageView.image = place.image
        }
        
        dataSource = UICollectionViewDiffableDataSource<PlacesController.PlacesCollection, Place>(collectionView: collectionsView) { (collectionsView: UICollectionView, indexPath: IndexPath, place: Place) -> UICollectionViewCell? in
            // Return the cell
            return collectionsView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: place)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: RootViewController.titleElementKind) { (supplementaryView, string, indexPath) in
            if let snapshot = self.currentSnapshot {
                // Populate the view with our section's description
                let placeCategory = snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.label.text = placeCategory.title
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionsView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
        
        currentSnapshot = NSDiffableDataSourceSnapshot<PlacesController.PlacesCollection, Place>()

        placesController.collections.forEach {
            let collection = $0
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.places)
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}
    
/*
// Related to Navigation bar
*/
extension RootViewController {

    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.hidesBarsOnTap = true
    }
    
    // Actions
    @objc func rightNavigationItemPressed() {
        print("rightNavigationItemPressed actions")
    }


}
