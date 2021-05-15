//
//  Utils.swift
//  xTimers
//
//  Created by  Buxlan on 3/31/21.
//

// Module which contains functions that are common for various apps

import UIKit

class Utils: NSObject {

    static func instantiateViewController(with name: Config.AvailableViewControllers, storyboardName: String = "Main") -> UIViewController {
        return UIStoryboard.init(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: name.rawValue)
    }

    static func isiPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static func isiPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
  
}
