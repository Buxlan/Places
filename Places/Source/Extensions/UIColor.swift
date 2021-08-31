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
    
    @available(iOS 12.0, *)
    static let label: UIColor = .black
    
    @available(iOS 12.0, *)
    static let secondaryLabel: UIColor = Asset.other0.color
    
    static let highlightedLabel = UIColor.label.withAlphaComponent(0.8)
    
    static let systemBackground: UIColor = Asset.other2.color
    static let secondarySystemBackground: UIColor = Asset.other1.color
    
    var image: UIImage {
        let pixel = CGSize(width: 1, height: 1)
        return UIGraphicsImageRenderer(size: pixel).image { context in
            self.setFill()
            context.fill(CGRect(origin: .zero, size: pixel))
        }
    }
    
}
