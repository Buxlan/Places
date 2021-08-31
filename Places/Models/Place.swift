//
//  Place.swift
//  Places
//
//  Created by  Buxlan on 5/7/21.
//

import Foundation
import CoreLocation
import UIKit

protocol ReusableObject {
    static var reuseIdentifier: String { get }
}

struct Place: ReusableObject {
        
    typealias PlaceCategory = String
    
    static var reuseIdentifier: String = String(describing: Self.self)
    static let empty = Place()
    
    let title: String
    let category: PlaceCategory
    let images: [UIImage] = {
        var items = [UIImage]()
        items.append(Asset.camera.image)
        items.append(Asset.lock.image)
        items.append(Asset.paintbrushPointedFill.image)
        items.append(Asset.person.image)
        return items
    }()
    let identifier = UUID()
    let description: String
    
    let latitude: CLLocationDegrees = 59.935317
    let longitude: CLLocationDegrees = 30.326959
    
    init() {
        title = ""
        category = ""
        description = ""
    }
    
    init(title: String, category: String, description: String) {
        self.title = title
        self.category = category
        self.description = description
    }
}

extension Place: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
