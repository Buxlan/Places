//
//  PlaceTableViewDirector.swift
//  Places
//
//  Created by  Buxlan on 5/21/21.
//

import UIKit

class PlaceTableViewDirector: NSObject {
    
    let actionsProxy = CellActionProxy()
    
    let tableView: UITableView
    var items: [CellConfigurator] {
        didSet {
            tableView.reloadData()
        }
    }
    var footerConfigurator: PlaceTableFooterConfigurator
    
    lazy var tableFooterView: UIView = {
        return PlaceTableViewFooter()
    }()
    
    init(tableView: UITableView,
         items: [CellConfigurator],
         footerConfigurator: PlaceTableFooterConfigurator) {
        self.tableView = tableView
        self.items = items
        self.footerConfigurator = footerConfigurator
        super.init()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(onActionEvent(n: )), name: CellAction.notificationName, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(onActionEvent(n:)), name: Place, object: <#T##Any?#>)
    }
    
    @objc fileprivate
    func onActionEvent(n: Notification) {
        if let eventData = n.userInfo?["data"] as? CellActionEventData,
           let cell = eventData.cell as? UITableViewCell,
           let indexPath = self.tableView.indexPath(for: cell) {
            actionsProxy.invoke(action: eventData.action, cell: cell, configurator: items[indexPath.row])
        } else if let eventData = n.userInfo?["data"] as? CellActionEventData {
            actionsProxy.invoke(action: eventData.action, object: footerConfigurator.item, view: eventData.cell)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension PlaceTableViewDirector: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseIdentifier)!
        item.configure(cell: cell)
        
        return cell
    }

}

extension PlaceTableViewDirector: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.row]
        return item.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.row]
        return item.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableFooterView
    }
    
    /* Handling actions */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // no need to keep cell selected
        tableView.deselectRow(at: indexPath, animated: true)
        let cellConfigurator = items[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) else {
            fatalError()
        }
        self.actionsProxy.invoke(action: .didSelect, cell: cell, configurator: cellConfigurator)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellConfigurator = items[indexPath.row]
        self.actionsProxy.invoke(action: .willDisplay, cell: cell, configurator: cellConfigurator)
    }
}
