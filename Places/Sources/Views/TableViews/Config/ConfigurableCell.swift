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
    func configure()
    func configure(data: DataType)
    func configureInterface(with options: [String: Any]?)
    func configureConstraints()
}

extension ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
    func configure() {}
}
