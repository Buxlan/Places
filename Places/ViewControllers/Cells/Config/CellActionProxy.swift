//
//  CellActionProxy.swift
//  Places
//
//  Created by  Buxlan on 5/21/21.
//

import UIKit

class CellActionProxy {
    //storage where subscrubers' closures are stored
    private var actions = [String: ((CellConfigurator, UIView) -> Void)]()
    
    //method to invoke cell action and notify all subscrubers
    func invoke(action: CellAction, cell: UIView, configurator: CellConfigurator) {
        let key = "\(action.hashValue)\(type(of: configurator).reuseId)"
        if let action = self.actions[key] {
            action(configurator, cell)
        }
    }
    
    // subscribe to cell action, returning self to chain subscriptions
    @discardableResult
    func on<CellType, DataType>(_ action: CellAction, handler: @escaping ( (TableCellConfigurator<CellType, DataType>, CellType) -> Void) ) -> Self {
        let key = "\(action.hashValue)\(CellType.reuseIdentifier)"
        self.actions[key] = { (c, cell) in
            handler(c as! TableCellConfigurator<CellType, DataType>, cell as! CellType)
        }
        return self
    }
}
