//
//  BottomCorneredImageView.swift
//  Places
//
//  Created by  Buxlan on 7/27/21.
//

import UIKit

class BottomCorneredImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomLeft, .bottomRight], radius: 50.0)
    }    
    
}
