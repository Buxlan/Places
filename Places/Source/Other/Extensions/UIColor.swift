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
    
    static let bxText0: UIColor = Asset.background0.color
    static let bxControlBackground: UIColor = Asset.background2.color
    static let bxText1: UIColor = Asset.foreground4.color
    static let bxShadow0: UIColor = Asset.foreground1.color
    static let bxShadow1: UIColor = Asset.foreground2.color
    static let bxSecondaryText: UIColor = Asset.foreground2.color
    static let bxTertiaryText: UIColor = Asset.background1.color
    
}
