//
//  ConfigurableView.swift
//  Places
//
//  Created by  Buxlan on 5/22/21.
//

import UIKit

protocol ConfigurableView: ReusableObject {
    
    associatedtype DataType
    func configure(data: DataType)
}

extension ConfigurableView {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}
