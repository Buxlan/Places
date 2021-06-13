//
//  PlaceLabelTableViewCell.swift
//  Places
//
//  Created by  Buxlan on 5/20/21.
//

import UIKit

class PlaceLabelTableViewCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet var placeLabel: UILabel!
    
    func configure(data: Place) {
        
        isUserInteractionEnabled = false
        
        placeLabel.text = data.title
        placeLabel.font = UIFont.bxControlTitle
        
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            placeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
