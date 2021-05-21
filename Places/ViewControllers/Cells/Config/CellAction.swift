//
//  CellAction.swift
//  Places
//
//  Created by  Buxlan on 5/21/21.
//

import UserNotifications
import UIKit

enum CellAction: Hashable {
    
    case didSelect
    case willDisplay
    case custom(String)
    
    func hash(into hasher: inout Hasher) {
        var value: Int
        switch self {
        case .didSelect:
            value = 0
        case .willDisplay:
            value = 1
        case .custom(let custom):
            value = custom.hashValue
        }
        hasher.combine(value)
    }
    
    static func ==(lhs: CellAction, rhs: CellAction) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}

struct CellActionEventData {
    let action: CellAction
    let cell: UIView
}

extension CellAction {
    static let notificationName = NSNotification.Name("CellAction")
    
    public func invoke(cell: UIView) {
        NotificationCenter.default.post(name: Self.notificationName, object: nil, userInfo: ["data": CellActionEventData(action: self, cell: cell)])
    }
}
