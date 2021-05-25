//
//  PlaceDescriptionTableViewCell.swift
//  Places
//
//  Created by  Buxlan on 5/21/21.
//

import UIKit

class PlaceDescriptionTableViewCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet var textView: UITextView!
    
    func configure(data: Place) {
        
        isUserInteractionEnabled = true
        
        textView.text = data.description
        textView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        textView.isScrollEnabled = false
        textView.isEditable = false

        textView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textView.topAnchor.constraint(equalTo: contentView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
