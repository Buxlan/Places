//
//  PlaceListTableViewCell.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import UIKit

class PlaceListCell: UITableViewCell, ConfigurableCell {
    
    weak var collectionDelegate: UICollectionViewDelegate? {
        didSet {
            reviewCollectionsView.delegate = collectionDelegate
        }
    }
    weak var collectionDataSource: UICollectionViewDataSource? {
        didSet {
            reviewCollectionsView.dataSource = collectionDataSource
        }
    }
    enum Option: String {
        case collectionDelegate
        case collectionDataSource
    }
    
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
    
    private lazy var reviewCollectionsView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Asset.other2.color
        view.isUserInteractionEnabled = true
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.translatesAutoresizingMaskIntoConstraints = false        
        view.register(ReviewCollectionViewCell.self,
                      forCellWithReuseIdentifier: ReviewCollectionViewCell.reuseIdentifier)
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
    
    func configureInterface(with options: [String: Any]? = nil) {
        if isInterfaceConfigured { return }
        tintColor = Asset.other1.color
        contentView.backgroundColor = Asset.other1.color
        roundedView.addSubview(placeLabel)
        roundedView.addSubview(reviewCollectionsView)
        roundedView.addSubview(likeButton)
        roundedView.addSubview(shareButton)
        contentView.addSubview(roundedView)
        configureConstraints()
        isInterfaceConfigured = true
        if let options = options {
            for option in options {
                switch option.key {
                case Option.collectionDataSource.rawValue:
                    if let obj = option.value as? UICollectionViewDataSource {
                        collectionDataSource = obj
                    }
                case Option.collectionDelegate.rawValue:
                    if let obj = option.value as? UICollectionViewDelegate {
                        collectionDelegate = obj
                    }
                default:
                    Log(text: "Attention! Wrong options have been passsed into the function configureInterfaceWithOptions")
                }
            }
        }
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            roundedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            roundedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            placeLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor),
            reviewCollectionsView.leadingAnchor.constraint(equalTo: placeLabel.leadingAnchor),
            likeButton.leadingAnchor.constraint(equalTo: placeLabel.leadingAnchor),
            shareButton.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor),
            
            placeLabel.topAnchor.constraint(equalTo: roundedView.topAnchor),
            reviewCollectionsView.topAnchor.constraint(equalTo: placeLabel.bottomAnchor),
            likeButton.topAnchor.constraint(equalTo: reviewCollectionsView.bottomAnchor, constant: 16),
            shareButton.topAnchor.constraint(equalTo: reviewCollectionsView.bottomAnchor, constant: 16),
            
            placeLabel.widthAnchor.constraint(equalTo: roundedView.widthAnchor),
            reviewCollectionsView.widthAnchor.constraint(equalTo: roundedView.widthAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 44),
            shareButton.widthAnchor.constraint(equalToConstant: 44),
            
            reviewCollectionsView.heightAnchor.constraint(equalTo: reviewCollectionsView.widthAnchor,
                                                   multiplier: 1.0),
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            shareButton.heightAnchor.constraint(equalToConstant: 44),
            
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
//        photoImageView.image = data.image.withRenderingMode(.alwaysOriginal)
//        photoImageView.setNeedsLayout()
//        contentView.setNeedsLayout()
//        contentView.layoutIfNeeded()
        
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

//class PlaceContentView: UIView {
//
//    init() {
//        super.init(frame: .zero)
//
//        self.addSubview(imageView)
//        self.addSubview(stackView)
//        self.addSubview(titleView)
//        self.addSubview(descriptionView)
//
//        let constraints: [NSLayoutConstraint] = [
//            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
//            imageView.topAnchor.constraint(equalTo: self.topAnchor),
//            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
//
//            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
//            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
//
//            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
//            titleView.widthAnchor.constraint(equalTo: self.widthAnchor),
//            titleView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
//
//            descriptionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
//            descriptionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
//            descriptionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8),
//            descriptionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//
////            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
////            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
////            likeButton.heightAnchor.constraint(equalTo: likeButton.widthAnchor),
////            likeButton.widthAnchor.constraint(equalToConstant: 30),
//
//        ]
//        likeButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//        NSLayoutConstraint.activate(constraints)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Private
//    private lazy var imageView: UIImageView = {
//        let imageView = UIImageView(frame: .zero)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//
//        return imageView
//    }()
//
//    private lazy var likeButton: UIButton = {
//        let view = UIButton()
//        view.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
//        let image = Asset.favorite.image
//        let selectedImage = Asset.fillFavorite.image
//
//        view.setImage(image, for: .normal)
//        view.setImage(selectedImage, for: .selected)
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//    }()
//
//    private lazy var shareButton: UIButton = {
//        let view = UIButton()
//        view.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
//        let image = Asset.share.image
//        view.setImage(image, for: .normal)
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//    }()
//
//    private lazy var stackView: UIStackView = {
//
//        var view = UIStackView(arrangedSubviews: [likeButton, shareButton])
//        view.backgroundColor = Asset.other1.color
//        view.axis = .horizontal
//        view.translatesAutoresizingMaskIntoConstraints = false
////        view.semanticContentAttribute = .forceRightToLeft
//        view.distribution = .equalSpacing
//        view.alignment = .trailing
//
//        return view
//
//    }()
//
//    private lazy var titleView: UILabel = {
//        let titleView = UILabel(frame: .zero)
//        titleView.font = UIFont.bxBody
//        titleView.translatesAutoresizingMaskIntoConstraints = false
//
//        return titleView
//    }()
//
//    private lazy var descriptionView: UILabel = {
//        let view = UILabel(frame: .zero)
//        view.font = UIFont.bxCaption
//        view.numberOfLines = 5
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//    }()
//
//    @objc
//    private func shareButtonTapped() {
//        self.shareButton.isSelected.toggle()
//        Log(text: "shareButtonTapped", object: nil)
//    }
//
//    @objc
//    private func likeButtonTapped() {
//        self.likeButton.isSelected.toggle()
//        Log(text: "shareButtonTapped", object: nil)
//    }
//
//}
