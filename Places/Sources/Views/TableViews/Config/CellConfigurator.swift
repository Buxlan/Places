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
    
    func configureInterface(cell: UIView, with options: ConfigurableCellInputOptions?)
    func configure(cell: UIView)
}

class TableCellConfigurator<CellType: ConfigurableCell,
                            DataType: Hashable>: CellConfigurator where CellType.DataType == DataType,
                                                                        CellType: UIView {
    // MARK: Properties
    static var reuseIdentifier: String { return CellType.reuseIdentifier }
    
    var item: DataType
    var isInterfaceConfigured: Bool = false
    var hash: Int {
        let hash = String(describing: CellType.self).hashValue ^ item.hashValue
        print("Hash is \(hash)")
        return hash
    }
    
    // MARK: Init
    init(item: DataType) {
        self.item = item
    }
    
    // MARK: Helper functions
    func configureInterface(cell: UIView, with options: ConfigurableCellInputOptions? = nil) {
        guard let cell = cell as? CellType else {
            Log(text: "Can't cast cell to \(CellType.self)", object: self)
            return
        }
        cell.configureInterface(with: options)
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

class CollectionCellConfigurator<CellType: ConfigurableCell,
                                 DataType: Hashable>: CellConfigurator where CellType.DataType == DataType, CellType: UIView {
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
    func configureInterface(cell: UIView, with options: ConfigurableCellInputOptions? = nil) {
        guard let cell = cell as? CellType else {
            Log(text: "Can't cast cell to \(CellType.self)", object: self)
            return
        }
        cell.configureInterface(with: options)
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
