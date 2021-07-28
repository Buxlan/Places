//
//  PlaceReview.swift
//  Places
//
//  Created by  Buxlan on 7/27/21.
//

import Foundation
import CoreLocation
import UIKit
import AVFoundation

struct Review: ReusableObject {
    
    typealias PlaceCategory = String
    
    static var reuseIdentifier: String = String(describing: Self.self)
    static let empty = Review()
    
    let author: Author
    let title: String
    let mainImage: UIImage = {
        Asset.person.image
    }()
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
    let rating: CGFloat
    let reviewCount: Int
    let audio: AudioUnit? = nil
        
    let workingTime: String
    let workingDays: [Int]
    
    init() {
        author = Author()
        title = "Spb"
        description = "Spb descr"
        rating = 5.0
        reviewCount = 234
        workingTime = "From 12 to 7 p.m."
        workingDays = [1, 2, 3, 4, 5]
    }
}

extension Review: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Review, rhs: Review) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
