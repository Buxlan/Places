//
//  ReviewImageCell.swift
//  Places
//
//  Created by  Buxlan on 7/28/21.
//

import UIKit

class ReviewImageCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet var placeImageView: UIImageView!
    var isInterfaceConfigured: Bool = true
        
    func configureInterface(with options: ConfigurableCellInputOptions? = nil) {
        if isInterfaceConfigured { return }
        configureConstraints()
    }
    
    internal func configureConstraints() {
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            placeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            placeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(data: Review) {
        isUserInteractionEnabled = true
        placeImageView.image = data.images[0]
    }
}
