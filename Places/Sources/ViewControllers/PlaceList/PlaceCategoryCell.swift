//
//  PlaceCategoryCell.swift
//  Places
//
//  Created by  Buxlan on 8/3/21.
//

import UIKit

class PlaceCategoryCell: UICollectionViewCell, ConfigurableCell {    
    
    internal var isInterfaceConfigured: Bool = false
        
    private lazy var containerView: UIView = {
        let backgroundColor = Asset.other0.color
        let cornerRadius: CGFloat = 8.0
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.borderColor = Asset.other0.color.cgColor
        view.clipsToBounds = true
        view.addSubview(iconImageView)
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let backgroundColor = Asset.other1.color
        let view = UIImageView()
        view.accessibilityIdentifier = "iconImageView"
        view.image = Asset.camera.image.resizeImage(to: 40,
                                                    aspectRatio: .current,
                                                    with: .red)
        view.backgroundColor = backgroundColor
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.font = .regularFont10
        return view
    }()
    
    func configureInterface(with options: ConfigurableCellInputOptions? = nil) {
        if isInterfaceConfigured { return }
        isUserInteractionEnabled = true
        tintColor = Asset.other0.color
        let backView = UIView()
        backView.backgroundColor = Asset.other1.color
        self.backgroundView = backView
        contentView.addSubview(nameLabel)
        contentView.addSubview(containerView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {        
        let constraints: [NSLayoutConstraint] = [
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 8),
            containerView.widthAnchor.constraint(equalTo: containerView.heightAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.9),
            
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(data: PlaceCategory) {
        nameLabel.text = data.title
        iconImageView.image = data.image
    }
}
