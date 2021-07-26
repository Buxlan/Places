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
        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.accent1.color
        view.translatesAutoresizingMaskIntoConstraints = false        
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        view.backgroundColor = Asset.other1.color
        let image = Asset.favorite.image
        let selectedImage = Asset.favoriteFill.image
        
        view.setImage(image, for: .normal)
        view.setImage(selectedImage, for: .selected)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var shareButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Asset.other1.color
        view.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        let image = Asset.share.image
        view.setImage(image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var toReviewsButton: UIButton = {
        let view = UIButton()
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
        view.image = Asset.camera.image//.resizeImage(to: 200, aspectRatio: .square, with: .red)
        view.backgroundColor = Asset.other0.color
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    init() {
        super.init(style: .default, reuseIdentifier: Self.reuseIdentifier)
    }
           
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isUserInteractionEnabled = true
        configureInterface()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init with code fatal error")
//        Log(text: "init with coder", object: nil)
    }
    
    func configureInterface() {
        tintColor = Asset.other1.color
        contentView.backgroundColor = Asset.other1.color
        roundedView.addSubview(placeLabel)
        roundedView.addSubview(photoImageView)
        roundedView.addSubview(likeButton)
        roundedView.addSubview(shareButton)
        contentView.addSubview(roundedView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            roundedView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundedView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            roundedView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            roundedView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            placeLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor),
            placeLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor),
            placeLabel.topAnchor.constraint(equalTo: roundedView.topAnchor),
//            placeLabel.bottomAnchor.constraint(greaterThanOrEqualTo: placeLabel.topAnchor,
//                                               constant: 44),
            placeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            
            photoImageView.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor),
//            photoImageView.widthAnchor.constraint(equalTo: roundedView.widthAnchor),
            photoImageView.topAnchor.constraint(equalTo: placeLabel.bottomAnchor),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: 1.0),
//            photoImageView.bottomAnchor.constraint(lessThanOrEqualTo: likeButton.topAnchor, constant: -8),
            
            likeButton.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor),
            likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor),
            likeButton.topAnchor.constraint(greaterThanOrEqualTo: photoImageView.bottomAnchor, constant: 8),
            likeButton.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            
            shareButton.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor),
            shareButton.widthAnchor.constraint(equalTo: shareButton.heightAnchor),
//            shareButton.topAnchor.constraint(greaterThanOrEqualTo: photoImageView.bottomAnchor, constant: 8),
            shareButton.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 44)
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

class PlaceContentView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(imageView)
        self.addSubview(stackView)
        self.addSubview(titleView)
        self.addSubview(descriptionView)
               
        let constraints: [NSLayoutConstraint] = [
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleView.widthAnchor.constraint(equalTo: self.widthAnchor),
            titleView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            
            descriptionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            descriptionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            descriptionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8),
            descriptionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
//            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
//            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
//            likeButton.heightAnchor.constraint(equalTo: likeButton.widthAnchor),
//            likeButton.widthAnchor.constraint(equalToConstant: 30),
            
        ]
        likeButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        NSLayoutConstraint.activate(constraints)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        let image = Asset.favorite.image
        let selectedImage = Asset.favoriteFill.image
        
        view.setImage(image, for: .normal)
        view.setImage(selectedImage, for: .selected)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var shareButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        let image = Asset.share.image
        view.setImage(image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        
        var view = UIStackView(arrangedSubviews: [likeButton, shareButton])
        view.backgroundColor = Asset.other1.color
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.semanticContentAttribute = .forceRightToLeft
        view.distribution = .equalSpacing
        view.alignment = .trailing
        
        return view
        
    }()
    
    private lazy var titleView: UILabel = {
        let titleView = UILabel(frame: .zero)
        titleView.font = UIFont.bxBody
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        return titleView
    }()
    
    private lazy var descriptionView: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.bxCaption
        view.numberOfLines = 5        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
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

}
