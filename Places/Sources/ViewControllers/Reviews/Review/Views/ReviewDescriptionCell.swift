//
//  ReviewDescriptionCell.swift
//  Places
//
//  Created by  Buxlan on 7/28/21.
//

import UIKit

class ReviewDescriptionCell: UITableViewCell, ConfigurableCell {
    
    var isInterfaceConfigured: Bool = true
    
    func configureInterface(with options: ConfigurableCellInputOptions? = nil) {
        
    }
    
    @IBOutlet var textView: UITextView!
    
    func configure(data: Review) {
        
        isUserInteractionEnabled = true
        
        textView.text = data.description
        textView.font = .bxBody
        textView.isScrollEnabled = false
        textView.isEditable = false
    }
    
    internal func configureConstraints() {
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
