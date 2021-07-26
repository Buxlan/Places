//
//  ConfigurableCell.swift
//  Places
//
//  Created by  Buxlan on 5/20/21.
//

import UIKit

protocol ConfigurableCell {
    
    static var reuseIdentifier: String { get }
    var isInterfaceConfigured: Bool { get set }
    
    associatedtype DataType
    func configure(data: DataType)
    func configureInterface()
    func configureConstraints()
}

extension ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}