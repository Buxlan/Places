//
//  Settings.swift
//  Places
//
//  Created by  Buxlan on 5/24/21.
//

import UIKit

//enum SettingNode: Hashable {
//    case stringValue(named: SettingName, value: String)
//    case boolValue(named: SettingName, value: Bool)
//}
//
//extension SettingNode: CustomStringConvertible {
//    var description: String {
//        switch self {
//        case .boolValue(let name, let value):
//            return "Setting with name \(name) has value \(value)"
//        case .stringValue(let name, let value):
//            return "Setting with name \(name) has value \(value)"
//        }
//    }
//}

class Settings {
    
    enum SettingName: String, CaseIterable {
        case notificationsAllowed
        case emailsAllowed
    }
    
//    var entries: [SettingNode] = [
//        SettingNode.boolValue(named: .notificationsAllowed, value: false),
//        SettingNode.stringValue(named: .password, value: "pass")
//    ]
    
    var notificationsAllowed: Bool {
        get { UserDefaults.standard.bool(forKey: SettingName.notificationsAllowed.rawValue) }
        set { UserDefaults.standard.setValue(newValue, forKey: SettingName.notificationsAllowed.rawValue) }
    }
    var emailsAllowed: Bool {
        get { UserDefaults.standard.bool(forKey: SettingName.emailsAllowed.rawValue) }
        set { UserDefaults.standard.setValue(newValue, forKey: SettingName.emailsAllowed.rawValue) }
    }
    
    init() {
        
    }
    
}
