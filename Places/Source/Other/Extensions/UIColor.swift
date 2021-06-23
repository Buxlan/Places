//
//  Colors.swift
//  Places
//
//  Created by  Buxlan on 6/4/21.
//

import UIKit

extension UIColor {
    
    static let bxBackground: UIColor = {
        let imageName = "background"
        if let color = UIColor(named: imageName) {
            return color
        } else {
            Log(text: "Color with name \(imageName) didn't found")
            return .black
        }
    }()
        
    static let bxControlBackground: UIColor = {
        let imageName = "controlBackground"
        if let color = UIColor(named: imageName) {
            return color
        } else {
            Log(text: "Color with name \(imageName) didn't found")
            return .black
        }
    }()
    
    static let bxLightText: UIColor = {
        let imageName = "lightText"
        if let color = UIColor(named: imageName) {
            return color
        } else {
            Log(text: "Color with name \(imageName) didn't found")
            return .black
        }
    }()
    
    static let bxDarkText: UIColor = {
        let imageName = "darkText"
        if let color = UIColor(named: imageName) {
            return color
        } else {
            Log(text: "Color with name \(imageName) didn't found")
            return .black
        }
    }()
    
    static let bxSecondaryText: UIColor = {
        let imageName = "secondaryText"
        if let color = UIColor(named: imageName) {
            return color
        } else {
            Log(text: "Color with name \(imageName) didn't found")
            return .black
        }
    }()
    
    static let bxTertiaryText: UIColor = {
        let imageName = "tertiaryText"
        if let color = UIColor(named: imageName) {
            return color
        } else {
            Log(text: "Color with name \(imageName) didn't found")
            return .black
        }
    }()
    
    static let bxPlaceholderText: UIColor = {
        let imageName = "placeholderText"
        if let color = UIColor(named: imageName) {
            return color
        } else {
            Log(text: "Color with name \(imageName) didn't found")
            return .black
        }
    }()
    
}
