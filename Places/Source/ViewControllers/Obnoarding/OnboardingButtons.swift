//
//  onboardingButton.swift
//  Places
//
//  Created by  Buxlan on 7/19/21.
//

import UIKit

class OnboardingFutherButton: UIButton {
    
    init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        
        setTitleColor(Asset.lightText.color, for: .normal)
        backgroundColor = Asset.controlBackground.color
        
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowColor = Asset.darkText.color.cgColor
        clipsToBounds = false
        layer.cornerRadius = layer.shadowRadius
               
        // configure insets
        self.contentEdgeInsets = UIEdgeInsets(top: 15, left: 40, bottom: 15, right: 40)
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class OnboardingSkipButton: UIButton {
    
    init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setImage(image, for: .normal)
        
        self.setTitleColor(Asset.secondaryText.color, for: .normal)
        self.backgroundColor = .clear
        
        self.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 12
        
        // configure insets
        self.contentEdgeInsets = UIEdgeInsets(top: 15, left: 40, bottom: 15, right: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
