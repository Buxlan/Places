//
//  UIImageExtension.swift
//  Places
//
//  Created by  Buxlan on 6/23/21.
//

import Foundation
import UIKit

extension UIImage {
      
    static var onboardingFirstImage: UIImage {
        let imageName = "onboarding1"
        guard let image = UIImage(named: imageName)
        else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
        return image
    }
    
    static var buildingIcon: UIImage = {
        let imageName = "bulding.columns"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var favoriteFilledIcon: UIImage = {
        let imageName = "favorite.fill"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var favoriteIcon: UIImage = {
        let imageName = "favorite"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var mapFilledIcon: UIImage = {
        let imageName = "map.fill"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var mapIcon: UIImage = {
        let imageName = "map"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var profileIcon: UIImage = {
        let imageName = "profile"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var profileFilledIcon: UIImage = {
        let imageName = "profile.fill"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var arrowRightIcon: UIImage = {
        let imageName = "arrow.right"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var closeIcon: UIImage = {
        let imageName = "close"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var shareIcon: UIImage = {
        let imageName = "share"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var likeIcon: UIImage = {
        let imageName = "like"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var likeFilledIcon: UIImage = {
        let imageName = "like.fill"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var lockIcon: UIImage = {
        let imageName = "lock"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    static var lockFilledIcon: UIImage = {
        let imageName = "lock.fill"
        if let image = UIImage(named: imageName) {
            return image
        } else {
            Log(text: "Can't find image with name \(imageName)")
            return UIImage()
        }
    }()
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
        
}
