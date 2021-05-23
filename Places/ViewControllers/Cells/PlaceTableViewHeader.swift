//
//  PlaceTableViewHeader.swift
//  Places
//
//  Created by  Buxlan on 5/23/21.
//

import UIKit

class PlaceTableViewHeader: UIView {
    
    
    
}

extension PlaceTableViewHeader: ReusableObject {
    
    static var reuseIdentifier: String {
        print(Self.self)
        return String(describing: Self.self)
    }
    
    
    
    
}
