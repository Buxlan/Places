//
//  CellActionProxy.swift
//  Places
//
//  Created by  Buxlan on 5/21/21.
//

import UIKit

class CellActionProxy {
    
    // storage where subscrubers' closures are stored
    private var actions = [String: ((CellConfigurator, UIView) -> Void)]()
    private var viewsActions = [String: (ReusableObject, UIView) -> Void]()
    
    // method to invoke cell action and notify all subscrubers
    func invoke(action: CellAction, cell: UIView, configurator: CellConfigurator) {
        let key = "\(action.hashValue)\(type(of: configurator).reuseIdentifier)"
        if let action = self.actions[key] {
            action(configurator, cell)
        }
        
    }
    
    func invoke(action: CellAction, object: ReusableObject, view: UIView) {
        let key = "\(action.hashValue)\(type(of: object).reuseIdentifier)"
        if let action = viewsActions[key] {
            action(object, view)
        }
    }
    
    // subscribe to cell action, returning self to chain subscriptions
    @discardableResult
    func on<CellType, DataType>(_ action: CellAction, handler: @escaping ( (TableCellConfigurator<CellType, DataType>, CellType) -> Void) ) -> Self {
        let key = "\(action.hashValue)\(CellType.reuseIdentifier)"
        self.actions[key] = { (config, cell) in
            if let config = config as? TableCellConfigurator<CellType, DataType>,
               let cell = cell as? CellType {
                handler(config, cell)
            }
        }
        return self
    }
    
    @discardableResult
    func on<DataType: ReusableObject>(_ action: CellAction, handler: @escaping ( (DataType, UIView) -> Void)) -> Self {
        let key = "\(action.hashValue)\(DataType.reuseIdentifier)"
        viewsActions[key] = { (object, view) in

            if let object = object as? DataType {
                handler(object, view)
            }
        }
        return self
    }
    
}
