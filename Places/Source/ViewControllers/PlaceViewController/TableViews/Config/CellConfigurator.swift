//
//  CellConfigurator.swift
//  Places
//
//  Created by  Buxlan on 5/20/21.
//

import UIKit

protocol CellConfigurator {
    static var reuseIdentifier: String { get }
    var cellHeight: CGFloat { get set }
    var hash: Int { get }
    
    func configure(cell: UIView)
}

class TableCellConfigurator<CellType: ConfigurableCell, DataType: Hashable>: CellConfigurator where CellType.DataType == DataType, CellType: UIView {
    static var reuseIdentifier: String { return CellType.reuseIdentifier }
    var cellHeight: CGFloat
    var hash: Int {
        let v = String(describing: CellType.self).hashValue ^ item.hashValue
        print("Hash is \(v)")
        return v
    }
    
    let item: DataType
    
    init(item: DataType, cellHeight: CGFloat) {
        self.item = item
        self.cellHeight = cellHeight
    }
    
    func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }
}

typealias PlaceImageTableCellConfigurator = TableCellConfigurator<PlaceImageTableViewCell, Place>
typealias PlaceLabelTableCellConfigurator = TableCellConfigurator<PlaceLabelTableViewCell, Place>
typealias PlaceUsefulButtonsCellConfigurator = TableCellConfigurator<PlaceUsefulButtonsTableViewCell, Place>
typealias PlaceDescriptionTableCellConfigurator = TableCellConfigurator<PlaceDescriptionTableViewCell, Place>
typealias PlaceMapTableCellConfigurator = TableCellConfigurator<PlaceMapTableViewCell, Place>
