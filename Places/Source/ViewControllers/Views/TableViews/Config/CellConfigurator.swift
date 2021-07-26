//
//  CellConfigurator.swift
//  Places
//
//  Created by  Buxlan on 5/20/21.
//

import UIKit

protocol CellConfigurator {
    static var reuseIdentifier: String { get }
    var hash: Int { get }
    var isInterfaceConfigured: Bool { get set }
//    var object: Any { get set }
    
    func configureInterface(cell: UIView)
    func configure(cell: UIView)
}

class TableCellConfigurator<CellType: ConfigurableCell,
                            DataType: Hashable>: CellConfigurator where CellType.DataType == DataType,
                                                                        CellType: UIView {
    static var reuseIdentifier: String { return CellType.reuseIdentifier }
    var hash: Int {
        let hash = String(describing: CellType.self).hashValue ^ item.hashValue
        print("Hash is \(hash)")
        return hash
    }
    
//    var object: Any
    var item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    var isInterfaceConfigured: Bool = false
    func configureInterface(cell: UIView) {
        guard let cell = cell as? CellType else {
            Log(text: "Can't cast cell to \(CellType.self)", object: self)
            return
        }
        cell.configureInterface()
        isInterfaceConfigured = true
    }
        
    func configure(cell: UIView) {
        guard let cell = cell as? CellType else {
            Log(text: "Can't cast cell to \(CellType.self)", object: self)
            return
        }
        cell.configure(data: item)
    }
}

typealias PlaceImageTableCellConfigurator = TableCellConfigurator<PlaceImageTableViewCell, Place>
typealias PlaceLabelTableCellConfigurator = TableCellConfigurator<PlaceLabelTableViewCell, Place>
typealias PlaceUsefulButtonsCellConfigurator = TableCellConfigurator<PlaceUsefulButtonsTableViewCell, Place>
typealias PlaceDescriptionTableCellConfigurator = TableCellConfigurator<PlaceDescriptionTableViewCell, Place>
typealias PlaceMapTableCellConfigurator = TableCellConfigurator<PlaceMapTableViewCell, Place>
typealias PlaceListCellConfigurator = TableCellConfigurator<PlaceListCell, Place>
