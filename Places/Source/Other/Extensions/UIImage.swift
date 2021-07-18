//
//  UIImageExtension.swift
//  Places
//
//  Created by  Buxlan on 6/23/21.
//

import Foundation
import UIKit

extension UIImage {
      
    static var onboardingFirstImage: UIImage? {
        let imageName = "onboarding1"
        let image = UIImage(named: imageName)
        return image
    }
    
    static var buildingIcon: UIImage? = {
        let imageName = "bulding.columns"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var favoriteFilledIcon: UIImage? = {
        let imageName = "favorite.fill"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var favoriteIcon: UIImage? = {
        let imageName = "favorite"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var mapFilledIcon: UIImage? = {
        let imageName = "map.fill"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var mapIcon: UIImage? = {
        let imageName = "map"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var profileIcon: UIImage? = {
        let imageName = "profile"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var profileFilledIcon: UIImage? = {
        let imageName = "profile.fill"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var arrowRightIcon: UIImage? = {
        let imageName = "arrow.right"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var closeIcon: UIImage? = {
        let imageName = "close"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var shareIcon: UIImage? = {
        let imageName = "share"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var likeIcon: UIImage? = {
        let imageName = "like"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var likeFilledIcon: UIImage? = {
        let imageName = "like.fill"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var lockIcon: UIImage? = {
        let imageName = "lock"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var lockFilledIcon: UIImage? = {
        let imageName = "lock.fill"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var micFilledIcon: UIImage? = {
        let imageName = "mic.fill"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var micIcon: UIImage? = {
        let imageName = "mic"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var playFilledIcon: UIImage? = {
        let imageName = "play.fill"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var playIcon: UIImage? = {
        let imageName = "play"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var lockSlashIcon: UIImage? = {
        let imageName = "lock.slash"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var lockSlashFilledIcon: UIImage? = {
        let imageName = "lock.slash.fill"
        let image = UIImage(named: imageName)
        return image
    }()
    
    static var phoneFilledIcon: UIImage? = {
        let imageName = "phone.fill"
        let image = UIImage(named: imageName)
        return image
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

    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        guard let context = CGContext(data: nil,
                                width: Int(width),
                                height: Int(height),
                                bitsPerComponent: 8,
                                bytesPerRow: 0,
                                space: colorSpace,
                                bitmapInfo: bitmapInfo.rawValue)
        else {
            return nil
        }
                
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }

}
