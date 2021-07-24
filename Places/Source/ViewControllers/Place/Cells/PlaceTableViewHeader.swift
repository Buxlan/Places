//
//  PlaceTableViewHeader.swift
//  Places
//
//  Created by  Buxlan on 5/23/21.
//

import UIKit

class PlaceTableViewHeader: UIView {
    
    lazy var label: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = .bxControlTitle
        label.textColor = UIColor.gray
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()
    
    static let tappedLogoAction: String = "tappedLogoAction"
    
    init() {
        
        super.init(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        configureUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PlaceTableViewHeader {
    func configureUI() {
        
        isUserInteractionEnabled = true
        
        backgroundColor = Asset.background0.color
        
        self.addSubview(label)
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.widthAnchor.constraint(equalTo: self.widthAnchor),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor),
            imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 250),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
 
    }
}

extension PlaceTableViewHeader: ConfigurableView {
    
    func configure(data: Place) {
        label.text = data.title
        imageView.setImage(data.image, animated: true)
        setNeedsLayout()
    }
  
}
