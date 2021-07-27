//
//  Author.swift
//  Places
//
//  Created by  Buxlan on 7/27/21.
//
import Foundation
import CoreLocation
import UIKit

struct Author: ReusableObject {
    
    static var reuseIdentifier: String = String(describing: Self.self)
    
    let name: String
    let displayName: String
    let photo: UIImage
    let email: String
    
    let identifier = UUID()
    
    init() {
        name = "Author"
        displayName = "Author"
        photo = Asset.person.image
        email = "author@mail.com"        
    }
}

extension Author: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Author, rhs: Author) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
