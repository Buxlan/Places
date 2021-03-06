//
//  PlaceListTableViewCell.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import UIKit

class PlaceListCell: UITableViewCell, ConfigurableCell {
       
    var isInterfaceConfigured: Bool = false    
    private let cornerRadius: CGFloat = 24.0
    
    private lazy var roundedView: UIView = {
        let view = CorneredView(corners: [.topLeft, .topRight], radius: cornerRadius)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.roundCorners(corners: [.allCorners], radius: 40)
//        view.clipsToBounds = true
        return view
    }()
    
    private lazy var placeLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "placeLabel"
        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.accent1.color
        view.translatesAutoresizingMaskIntoConstraints = false        
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "likeButton"
        view.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        view.backgroundColor = Asset.other1.color
        let image = Asset.favorite.image
        let selectedImage = Asset.fillFavorite.image
        
        view.setImage(image, for: .normal)
        view.setImage(selectedImage, for: .selected)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var shareButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "shareButton"
        view.backgroundColor = Asset.other1.color
        view.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        let image = Asset.share.image
        view.setImage(image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var toReviewsButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "toReviewsButton"
        view.backgroundColor = Asset.other1.color
        view.setTitle(L10n.PlacesList.toReviews, for: .normal)
        view.addTarget(self, action: #selector(toReviewsTapped), for: .touchUpInside)
        let image = Asset.share.image
        view.setImage(image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
        let view = CorneredImageView(corners: [.bottomLeft, .bottomRight], radius: cornerRadius)
//        view.layer.cornerRadius = 50
//        view.clipsToBounds = true
        view.accessibilityIdentifier = "photoImageView"
        view.image = Asset.camera.image
        view.backgroundColor = Asset.other0.color
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var reviewsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Asset.other2.color
        view.isUserInteractionEnabled = true
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        view.register(ReviewCollectionCell.self,
                      forCellWithReuseIdentifier: ReviewCollectionCell.reuseIdentifier)
        return view
    }()
    
    init() {
        super.init(style: .default, reuseIdentifier: Self.reuseIdentifier)
    }
           
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isUserInteractionEnabled = true
//        configureInterface()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init with code fatal error")
//        Log(text: "init with coder", object: nil)
    }
    
    func configureInterface(with options: ConfigurableCellInputOptions? = nil) {
        if isInterfaceConfigured { return }
        tintColor = Asset.other1.color
        contentView.backgroundColor = Asset.other1.color
        roundedView.addSubview(placeLabel)
        roundedView.addSubview(reviewsCollectionView)
        roundedView.addSubview(likeButton)
        roundedView.addSubview(shareButton)
        contentView.addSubview(roundedView)
        configureConstraints()
        isInterfaceConfigured = true
        
        reviewsCollectionView.dataSource = options?.collectionViewDataSource
        reviewsCollectionView.delegate = options?.collectionViewDelegate
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            roundedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            roundedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            placeLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor),
            reviewsCollectionView.leadingAnchor.constraint(equalTo: placeLabel.leadingAnchor),
            likeButton.leadingAnchor.constraint(equalTo: placeLabel.leadingAnchor),
            shareButton.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor),
            
            placeLabel.topAnchor.constraint(equalTo: roundedView.topAnchor),
            reviewsCollectionView.topAnchor.constraint(equalTo: placeLabel.bottomAnchor),
            likeButton.topAnchor.constraint(equalTo: reviewsCollectionView.bottomAnchor, constant: 16),
            shareButton.topAnchor.constraint(equalTo: reviewsCollectionView.bottomAnchor, constant: 16),
            
            placeLabel.widthAnchor.constraint(equalTo: roundedView.widthAnchor),
            reviewsCollectionView.widthAnchor.constraint(equalTo: roundedView.widthAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 32),
            shareButton.widthAnchor.constraint(equalToConstant: 32),
            
            reviewsCollectionView.heightAnchor.constraint(equalTo: reviewsCollectionView.widthAnchor,
                                                   multiplier: 1.0),
            likeButton.heightAnchor.constraint(equalToConstant: 32),
            shareButton.heightAnchor.constraint(equalToConstant: 32),
            
            likeButton.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -8),
            shareButton.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -8)
           
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(data: Place) {
        isUserInteractionEnabled = true
        
        placeLabel.text = data.title
        placeLabel.font = UIFont.bxControlTitle
        placeLabel.setMargins(margin: 32.0)
    }
    
    @objc
    private func shareButtonTapped() {
        self.shareButton.isSelected.toggle()
        Log(text: "shareButtonTapped", object: nil)
    }
    
    @objc
    private func likeButtonTapped() {
        self.likeButton.isSelected.toggle()
        Log(text: "shareButtonTapped", object: nil)
    }
    
    @objc
    private func toReviewsTapped() {
        self.toReviewsButton.isSelected.toggle()
        Log(text: "toReviewsButton", object: nil)
    }
}
