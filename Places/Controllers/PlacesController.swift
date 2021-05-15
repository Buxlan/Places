//
//  PlacesController.swift
//  Places
//
//  Created by  Buxlan on 5/7/21.
//

import Foundation

class PlacesController {
    
    struct PlacesCollection: Hashable {
        let title: String
        let places: [Place]
        
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    var collections: [PlacesCollection] {
        return _collections
    }
    
    init() {
        generateCollections()
    }
    fileprivate var _collections = [PlacesCollection]()
    
}

extension PlacesController {
    func generateCollections() {
        _collections = [
            PlacesCollection(title: "Most popular places", places: [
                Place(title: "Nevskiy prospect", category: "Category 1"),
                Place(title: "Parnas", category: "Category 2"),
                Place(title: "Hermitage", category: "Category 3"),
            ]),
            PlacesCollection(title: "New places!", places: [
                Place(title: "Vas'ka", category: "Category 1"),
                Place(title: "Prosvet", category: "Category 2"),
                Place(title: "Devyatkino", category: "Category 3"),
            ]),
        ]
    }
}
