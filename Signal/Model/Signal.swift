//
//  Signal.swift
//  Autosignal
//
//  Created by Buxlan on 03/05/2020.
//  Copyright © 2020 Buxlan. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI

class Signal: Codable, Identifiable, Hashable {
    
    static func == (lhs: Signal, rhs: Signal) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum SignalKind {
        case incoming
        case outgoing
    }
    
    var id: Int
    var kind: SignalKind
    
    var sender: Sender
    var carNum: CarNumber
    var date: Date
//    var senderIP: IP? { get set }
    var geotag: CLLocationCoordinate2D?
    var type: SignalType
    
    init(id: Int,
         kind: SignalKind,
         sender: Sender,
         carNum: CarNumber,
         date: Date,
         geotag: CLLocationCoordinate2D?,
         type: SignalType) {
        
        self.id = id
        self.kind = kind
        self.sender = sender
        self.carNum = carNum
        self.date = date
        self.geotag = geotag
        self.type = type
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case kind = "kind"
        case sender = "sender"
        case carNum = "carnum"
        case date = "date"
        case geotag = "geotag"
        case type = "type"
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        switch kind {
        case .incoming:
            try container.encode(0, forKey: .kind)
        case .outgoing:
            try container.encode(1, forKey: .kind)
        }
        try container.encode(sender, forKey: .sender)
        try container.encode(carNum, forKey: .carNum)
        try container.encode(date, forKey: .date)
        try container.encode(geotag, forKey: .geotag)
        try container.encode(type, forKey: .type)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        let rawKind = try container.decode(Int.self, forKey: .kind)
        switch rawKind {
        case 0:
            self.kind = .incoming
        case 1:
            self.kind = .outgoing
        default:
            throw CodingError.unknownValue
        }
        sender = try container.decode(Sender.self, forKey: .sender)
        carNum = try container.decode(CarNumber.self, forKey: .carNum)
        date = try container.decode(Date.self, forKey: .date)
        geotag = try container.decode(CLLocationCoordinate2D.self, forKey: .geotag)
        type = try container.decode(SignalType.self, forKey: .type)
    }
    
}

extension Signal {
    
    var damageText: String {
        switch self.type.category {
        case .damage:
            return "У Вашего автомобиля\nповреждено остекление.\nЛучше бы Вам самим на это взглянуть."
        case .parking:
            return "Ваш автомобиль мешает проезду.\nПрошу как можно скорее вернуться\nк своему транспортному средству"
        case .roadAccident:
            let phone = self.sender.phone
            let sender = self.sender.name
            if phone.isEmpty {
                return "Я повредил Ваш автомобиль. \nПрошу срочно подойти!"
            } else {
                return "Я повредил Ваш автомобиль. \nПрошу перезвонить мне по номеру\n\(phone)\nС уважением, \(sender)"
            }
        }
    }
}

extension CLLocationCoordinate2D: Codable {
    
    enum CodingKeys: String, CodingKey {
        case longitude
        case latitude
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        
        self = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
