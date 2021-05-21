//
//  PlaceImageTableViewCell.swift
//  Places
//
//  Created by  Buxlan on 5/18/21.
//

import UIKit

class PlaceImageTableViewCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet var placeImageView: UIImageView!
    
    func configure(data: Place) {
        
        isUserInteractionEnabled = true
        placeImageView.image = data.image
        
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            placeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            placeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
}
