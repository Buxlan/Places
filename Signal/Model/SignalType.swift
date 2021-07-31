//
//  SignalType.swift
//  Autosignal
//
//  Created by Buxlan on 03/05/2020.
//  Copyright © 2020 Buxlan. All rights reserved.
//

import Foundation
import SwiftUI

struct Root: Codable {
    let id, name: String
 
}

struct SignalType: Identifiable, Codable {
    
    var id: Int
    var name: String
    var category: Category
    var color: ColorComponents
    
    struct ColorComponents: Codable {
        var red: Double
        var green: Double
        var blue: Double
    }
    
    enum Category: String, Codable {
        case parking = "Parking"
        case roadAccident = "Road accident"
        case damage = "Car damage"
    }
    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: <#T##CodingKey.Protocol#>)
//
//    }
    
}

extension SignalType {
    
    static let allTypes: [SignalType] = loadFromFile("signalTypes.json")

    fileprivate static func loadFromFile<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Could't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Could't parse \(filename) as \(T.self):\n\(error)")
        }
    } // loadFromFile   
    
}

