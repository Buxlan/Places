//
//  Colors.swift
//  Places
//
//  Created by  Buxlan on 6/4/21.
//

import UIKit

extension UIColor {
        
//    static let highlightedLabel = UIColor.label.withAlphaComponent(0.8)
    
    var highlighted: UIColor { withAlphaComponent(0.8) }
    
    var image: UIImage {
        let pixel = CGSize(width: 1, height: 1)
        return UIGraphicsImageRenderer(size: pixel).image { context in
            self.setFill()
            context.fill(CGRect(origin: .zero, size: pixel))
        }
    }
    
}
