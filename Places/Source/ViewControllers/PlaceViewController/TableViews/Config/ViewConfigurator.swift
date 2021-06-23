//
//  ViewConfigurator.swift
//  Places
//
//  Created by  Buxlan on 5/22/21.
//

import UIKit

protocol ViewConfigurator {
    static var reuseIdentifier: String { get }
    
    func configure(view: UIView)
}

class ReusableViewConfigurator<ViewType: ConfigurableView,
                               DataType: ReusableObject>: ViewConfigurator where ViewType.DataType == DataType, ViewType: UIView {
    
    static var reuseIdentifier: String { return DataType.reuseIdentifier }
    
    let item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(view: UIView) {
        if let view = view as? ViewType {
            view.configure(data: item)
        }
    }
}

typealias PlaceTableFooterConfigurator = ReusableViewConfigurator<PlaceTableViewFooter, Place>
typealias PlaceTableHeaderConfigurator = ReusableViewConfigurator<PlaceTableViewHeader, Place>
