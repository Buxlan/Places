//
//  Sender.swift
//  ASign
//
//  Created by  Buxlan on 21.09.2020.
//  Copyright © 2020  Buxlan. All rights reserved.
//

import Foundation

struct Sender: Codable, Hashable {
    
    let id: Int
    private let _name: String?
    private let _phone: String?
    
    init(id: Int,
        name: String?,
        phone: String? ){
               
        self.id = id
        self._name = name
        self._phone = phone
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case phone = "phone"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(_name, forKey: .name)
        try container.encode(_phone, forKey: .phone)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        _name = try container.decode(String.self, forKey: .name)
        _phone = try container.decode(String.self, forKey: .phone)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

extension Sender {
     
    var phone: String {
        
        get {
            if let phoneNum = self._phone {
                return phoneNum
            } else {
                return "Отсутствует"
            }
        }
        
    }
    
    var name: String {
        
        if let name = self._name {
            return name
        } else {
            return "Аноним"
        }
        
    }
    
}
