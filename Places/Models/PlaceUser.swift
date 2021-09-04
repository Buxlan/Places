//
//  User.swift
//  Places
//
//  Created by  Buxlan on 8/1/21.
//
import Foundation
import UIKit
import FirebaseAuth

class PlaceUser: Identifiable {
    
    // MARK: - Properties    
    static var current: PlaceUser {
        return PlaceUser()
    }
    static var unsignedUser = PlaceUser()
    var settings: PlaceAppSettings
    
    var id: String {
        Auth.auth().currentUser?.uid ?? String.empty
    }
    var displayName: String? {
        Auth.auth().currentUser?.displayName ?? String.empty
    }
    var photoURL: URL? {
        Auth.auth().currentUser?.photoURL ?? nil
    }
    var email: String? {
        Auth.auth().currentUser?.email ?? nil
    }
    var isLogged: Bool {
        return Auth.auth().currentUser != nil
    }
    
    // MARK: - Init
    init(settings: PlaceAppSettings) {
        self.settings = settings
    }
    
    init() {
        settings = PlaceAppSettings()
    }
    
}
