//
//  User.swift
//  Places
//
//  Created by  Buxlan on 8/1/21.
//
import Foundation
import UIKit

class PlaceUser: Identifiable, Codable {
    
    // MARK: - Properties    
    static var current: PlaceUser {
        let user = UserDefaults.standard.value(forKey: UserDefaultKey.loggedUser.rawValue)
        if let user = user,
           let castedUser = user as? PlaceUser {
            castedUser.isLogged = true
            return castedUser
        }
        return PlaceUser()
    }
    static var unsignedUser = PlaceUser()
    
    let id: UUID
    var name: String
    var displayName: String
    var imageName: String = "lock"
    var settings: PlaceAppSettings
    var email: String = "buxlan@yandex.ru"
    var contacts: String = "+ 7 545 341234"
    var isLogged: Bool = false
    var image: UIImage? {
        UIImage(named: imageName)
    }
    
    // MARK: - Init
    init(id: UUID, name: String, displayName: String, settings: PlaceAppSettings) {
        self.name = name
        self.displayName = displayName
        self.settings = settings
        self.id = id
    }
    
    init() {
        name = L10n.User.unregistered
        displayName = L10n.User.displayUnregistered
        settings = PlaceAppSettings()
        id = UUID()
    }
    
}
