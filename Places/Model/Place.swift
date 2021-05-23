//
//  Place.swift
//  Places
//
//  Created by  Buxlan on 5/7/21.
//

import Foundation
import UIKit
import CoreLocation

protocol ReusableObject {
    static var reuseIdentifier: String { get }
}

struct Place: Hashable, ReusableObject {
    
    typealias PlaceCategory = String
    
    static let storyboardName = "Place"
    static let viewControllerName = "Place"
    static let reuseIdentifier = "Place"
    
    let title: String
    let category: PlaceCategory
    let image: UIImage = {
        guard let image = UIImage(systemName: "photo") else { fatalError() }
        return image
    }()
    let identifier = UUID()
    let description: String
    
    let latitude: CLLocationDegrees = 59.935317
    let longitude: CLLocationDegrees = 30.326959
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
