//
//  Extensions.swift
//  Places
//
//  Created by  Buxlan on 5/6/21.
//

import UIKit

extension UIColor {
    static let bxColorTypeOne = UIColor.white
}

extension UIView {
    // Function finds root view controller
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
