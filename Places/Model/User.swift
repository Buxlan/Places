//
//  User.swift
//  Places
//
//  Created by  Buxlan on 8/1/21.
//
import Foundation

class User: Identifiable {
    
    // MARK: - Properties
    static var current: User = User()
    
    let id: UUID
    var name: String
    var displayName: String
    var settings: Settings
    var image: String = "lock"
    var email: String = "buxlan@yandex.ru"
    var contacts: String = "+ 7 545 341234"
    
    // MARK: - Init
    init(id: UUID, name: String, displayName: String, settings: Settings) {
        self.name = name
        self.displayName = displayName
        self.settings = settings
        self.id = id
    }
    
    init() {
        name = L10n.User.unregistered
        displayName = L10n.User.displayUnregistered
        settings = Settings()
        id = UUID()
    }
}
