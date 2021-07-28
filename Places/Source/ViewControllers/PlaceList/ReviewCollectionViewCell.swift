//
//  ImageCollectionViewCell.swift
//  Places
//
//  Created by  Buxlan on 7/27/21.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    
    internal var isInterfaceConfigured: Bool = false
    
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
    
    private lazy var photoImageView: UIImageView = {
        let cornerRadius: CGFloat = 32.0
        let view = UIImageView()
        view.accessibilityIdentifier = "photoImageView"
        view.image = Asset.camera.image.resizeImage(to: 300, aspectRatio: .current, with: .red)
        view.backgroundColor = Asset.other0.color
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    func configureInterface(with options: [String: Any]? = nil) {
        if isInterfaceConfigured { return }
        tintColor = Asset.other1.color
        let backView = UIView()
        backView.backgroundColor = Asset.other0.color
        backgroundView = backView
        contentView.addSubview(placeLabel)
        contentView.addSubview(photoImageView)
        contentView.addSubview(likeButton)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
//            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            photoImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
            
//            photoImageView.leadingAnchor.constraint(equalTo: placeLabel.leadingAnchor),
//            photoImageView.topAnchor.constraint(equalTo: placeLabel.bottomAnchor),
//            photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor,
//                                                   multiplier: 1.0),
//
//            placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            placeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            placeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//
//            likeButton.leadingAnchor.constraint(equalTo: placeLabel.leadingAnchor),
//            likeButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
//            likeButton.widthAnchor.constraint(equalToConstant: 44),
//            likeButton.heightAnchor.constraint(equalToConstant: 44),
//            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
            placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeLabel.heightAnchor.constraint(equalToConstant: 24),
            placeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            photoImageView.leadingAnchor.constraint(equalTo: placeLabel.leadingAnchor),
            photoImageView.topAnchor.constraint(equalTo: placeLabel.bottomAnchor),
            photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            photoImageView.heightAnchor.constraint(lessThanOrEqualTo: photoImageView.widthAnchor,
                                                   multiplier: 1.0),
            
            likeButton.leadingAnchor.constraint(equalTo: placeLabel.leadingAnchor),
            likeButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            likeButton.widthAnchor.constraint(equalToConstant: 24),
            likeButton.heightAnchor.constraint(equalToConstant: 24),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(data: Review) {
        isUserInteractionEnabled = true
        
        placeLabel.text = data.title
        photoImageView.image = data.mainImage
//        photoImageView.image = data.image.withRenderingMode(.alwaysOriginal)
//        photoImageView.setNeedsLayout()
//        contentView.setNeedsLayout()
//        contentView.layoutIfNeeded()
        
    }
    
    @objc
    private func likeButtonTapped() {
        self.likeButton.isSelected.toggle()
        Log(text: "shareButtonTapped", object: nil)
    }
    
}
