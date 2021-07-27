//
//  PlaceLabelTableViewCell.swift
//  Places
//
//  Created by  Buxlan on 5/20/21.
//

import UIKit

class PlaceLabelTableViewCell: UITableViewCell, ConfigurableCell {
    
    var isInterfaceConfigured: Bool = true
    
    func configureInterface(with options: [String: Any]? = nil) {
        
    }
    
    @IBOutlet var placeLabel: UILabel!
    
    func configure(data: Place) {
        
        isUserInteractionEnabled = true        
        placeLabel.text = data.title
        placeLabel.font = UIFont.bxControlTitle
        
    }
    
    internal func configureConstraints() {
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
