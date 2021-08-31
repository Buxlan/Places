//
//  PlaceAppSettings.swift
//  Places
//
//  Created by  Buxlan on 5/24/21.
//

import UIKit

class PlaceAppSettings: NSObject, Codable {
    
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
    
    override init() {
        
    }
    
}
