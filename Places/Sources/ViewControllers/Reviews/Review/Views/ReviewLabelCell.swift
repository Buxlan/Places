//
//  ReviewLabelCell.swift
//  Places
//
//  Created by  Buxlan on 7/28/21.
//

import UIKit

class ReviewLabelCell: UITableViewCell, ConfigurableCell {
    
    var isInterfaceConfigured: Bool = true
    @IBOutlet var dataLabel: UILabel!
    
    func configureInterface(with options: ConfigurableCellInputOptions? = nil) {
        if isInterfaceConfigured { return }
    }
    
    func configure(data: Review) {
        isUserInteractionEnabled = true
        dataLabel.text = data.title
        dataLabel.font = UIFont.bxControlTitle
    }
    
    internal func configureConstraints() {
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            dataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dataLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
