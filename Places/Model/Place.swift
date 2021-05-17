//
//  Place.swift
//  Places
//
//  Created by  Buxlan on 5/7/21.
//

import Foundation
import UIKit

struct Place: Hashable {
    
    typealias PlaceCategory = String
    
    static let storyboardName = "Place"
    static let viewControllerName = "Place"
    
    let title: String
    let category: PlaceCategory
    let image: UIImage = {
        guard let image = UIImage(systemName: "photo") else { fatalError() }
        return image
    }()
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
