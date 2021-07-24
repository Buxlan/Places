//
//  Layers.swift
//  Places
//
//  Created by  Buxlan on 7/19/21.
//

import UIKit

class ShadowLayer: CALayer {
    
    override init() {
        super.init()
        shadowRadius = 8
        shadowOpacity = 0.4
        shadowOffset = CGSize(width: 4, height: 4)
        shadowColor = UIColor.bxText1.cgColor
        masksToBounds = false
        cornerRadius = shadowRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
