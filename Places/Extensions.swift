//
//  Extensions.swift
//  Places
//
//  Created by  Buxlan on 5/6/21.
//

import UIKit
import ListDiff

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

extension UIImageView{
    func setImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}

extension UIImage {
    
    static func bxPreferredSymbol(with systemName: String) -> UIImage? {
        var settings = AppSettings()
        let configuration = settings.symbolPreferredConfiguration
        let symbol = UIImage(systemName: systemName, withConfiguration: configuration)
        return symbol
    }
    
}

extension Int : Diffable {
    public var diffIdentifier: AnyHashable {
        return self
    }
}

extension UITableView {
    func perform(result: List.Result) {
        if result.hasChanges {
            self.beginUpdates()
            if !(result.deletes.isEmpty) {
                self.deleteRows(at: result.deletes.compactMap {
                    IndexPath(row: $0, section: 0)
                }, with: .automatic)
            }
            if !result.inserts.isEmpty {
                self.insertRows(at: result.inserts.compactMap { IndexPath(row: $0, section: 0) }, with: .automatic)
            }
            if !result.updates.isEmpty {
                self.reloadRows(at: result.updates.compactMap { IndexPath(row: $0, section: 0) }, with: .automatic)
            }
            if !result.moves.isEmpty {
                result.moves.forEach({ (index) in
                    let toIndexPath = IndexPath(row: index.to, section: 0)
                    self.moveRow(at: IndexPath(row: index.from, section: 0), to: toIndexPath)
                })
            }
            self.endUpdates()
        }
    }
}
