//
//  Settings.swift
//  Places
//
//  Created by  Buxlan on 5/24/21.
//

import UIKit

struct AppSettings {
    
    enum Appearance {
        case light
        case dark
    }
    
    lazy var appearance: Appearance = .light
    
    var config: Config!
    
    init() {
        
        initConfig()
        
    }
    
    private mutating func initConfig() {
        if appearance == .light {
             config = Config(type: .light)
        } else {
            config = Config(type: .dark)
        }
    }
    
}