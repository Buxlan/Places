//
//  PlaceUsefulButtonsTableViewCell.swift
//  Places
//
//  Created by  Buxlan on 5/20/21.
//

import UIKit

class PlaceUsefulButtonsTableViewCell: UITableViewCell, ConfigurableCell {
    
    var isInterfaceConfigured: Bool = true
    
    func configureInterface(with options: ConfigurableCellInputOptions? = nil) {
        
    }
    
    static let reviewsAction = "placeReviewsAction"
    static let addToFavoriteAction = "placeAddToFavoriteAction"
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var buttonViews: UIButton!
    @IBOutlet var buttonReviews: UIButton!
    @IBOutlet var buttonFollow: UIButton!
    
    func configure(data: Place) {
        isUserInteractionEnabled = true       
    }
    
    internal func configureConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @IBAction func reviewsTapped(_ sender: UIButton) {
//        print("It isn't implemented")
        CellAction.custom(type(of: self).reviewsAction).invoke(cell: self)
    }
    
    @IBAction func followTapped(_ sender: UIButton) {
//        UIView.animate(withDuration: 1) {
//            let tintColor = self.buttonFollow.imageView?.tintColor
//            self.buttonFollow.imageView?.tintColor = (tintColor == .systemRed ? .clear : .systemRed ).systemRed
//        }
        CellAction.custom(type(of: self).addToFavoriteAction).invoke(cell: self)
    }
}

extension PlaceUsefulButtonsTableViewCell {
            
}
