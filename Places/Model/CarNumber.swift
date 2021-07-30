//
//  CarNumber.swift
//  Autosignal
//
//  Created by Buxlan on 14/05/2020.
//  Copyright © 2020 Buxlan. All rights reserved.
//

import Foundation

struct CarNumber: Codable {
    
    private var _rawNumber: String
    
    var rawNumber: String {
        
        set {
            _rawNumber = newValue
        }
        
        get {
            return _rawNumber.uppercased()
        }
    }
    
    var internationalNumber: String {
        get {
            if !self.isNumberValid { return "" }
            
            var tmpNumber: String = ""
            var counter = 0
            
            rawNumber.forEach { ch in
                counter += 1
                if (counter == 1 || counter == 5 || counter == 6) && Self.validRussianLiterals.contains(ch) {
                    tmpNumber.append(Self.transformDict[ch] ?? " ")
                } else {
                    tmpNumber.append(ch)
                }
            }
            return tmpNumber
        }
    }
    
    var region: String? {
        if !self.isNumberValid { return nil }
        
        let range = rawNumber.index(rawNumber.startIndex, offsetBy: 6)..<rawNumber.endIndex
        var tmpRegion: String? = String(rawNumber[range])
        
        guard tmpRegion != nil else { return nil }
                
        tmpRegion!.forEach { ch in
            if !ch.isNumber {
                tmpRegion = nil
                return
            }
        }
        return tmpRegion
    }
    
    fileprivate static let validRussianLiterals: String = "АВЕКМНОРСТУХ"
    fileprivate static let validinternationalLiterals: String = "ABEKMHOPCTYX"
    fileprivate static let transformDict: [Character : Character] = ["А": "A",
                                                                                    "В": "B",
                                                                                    "Е": "E",
                                                                                    "К": "K",
                                                                                    "М": "M",
                                                                                    "Н": "H",
                                                                                    "О": "O",
                                                                                    "Р": "P",
                                                                                    "С": "C",
                                                                                    "Т": "T",
                                                                                    "У": "Y",
                                                                                    "Х": "X"]
    
    var isNumberValid: Bool {
        get {
               
            if rawNumber.count < 8 || rawNumber.count > 9 {
                return false
            }
            
            var counter = 0
            var isValid = true
            
            rawNumber.forEach { ch in
                counter += 1
                
                guard isValid else { return }
                            
                if counter == 1 || counter == 5 || counter == 6 {
                    isValid = Self.isValidLiteral(character: ch)
                } else if counter >= 2 && counter <= 4 || counter > 6 {
                    isValid = Self.isValidNumber(character: ch)
                }
            }
            return isValid
        }
    }
    
    init(_ number: String) {
        _rawNumber = number
    }
       
    private static func isValidNumber(character ch: Character) -> Bool {
        if ch.isNumber {
            return true
        }
        return false
    }
    
    private static func isValidLiteral(character ch: Character) -> Bool {
        if Self.validinternationalLiterals.contains(ch)
            || Self.validRussianLiterals.contains(ch) {
            return true
        }
        return false
    }
    
    
    
}
