//
//  onboardingButton.swift
//  Places
//
//  Created by  Buxlan on 7/19/21.
//

import UIKit

class ButtonWithShadow: UIButton {
    
    override class var layerClass: AnyClass {
        return ShadowLayer.self
    }
    
    init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        
        setTitleColor(Asset.other0.color, for: .normal)
        backgroundColor = Asset.other0.color
        
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        
        translatesAutoresizingMaskIntoConstraints = false
                               
        // configure insets
        self.contentEdgeInsets = UIEdgeInsets(top: 8,
                                              left: 32,
                                              bottom: 8,
                                              right: 32)
    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: 0, height: 40)
//    }
        
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
        
        self.setTitleColor(Asset.other1.color, for: .normal)
        self.backgroundColor = .clear
        
        self.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // configure insets
        self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 40, bottom: 8, right: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
