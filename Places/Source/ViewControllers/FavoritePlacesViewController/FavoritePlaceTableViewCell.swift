//
//  FavoritePlaceTableViewCell.swift
//  Places
//
//  Created by  Buxlan on 6/14/21.
//

import UIKit

class FavoritePlaceTableViewCell: UITableViewCell {
           
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        isUserInteractionEnabled = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init with code fatal error")
//        Log(text: "init with coder", object: nil)
    }
    
}
