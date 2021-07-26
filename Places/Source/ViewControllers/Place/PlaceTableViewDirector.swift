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
    private var footerConfigurator: PlaceTableFooterConfigurator
    private var headerConfigurator: PlaceTableHeaderConfigurator
    
    private lazy var tableFooterView: UIView = {
        return PlaceTableViewFooter()
    }()
    
    private lazy var tableHeaderView: UIView = {
        return PlaceTableViewHeader()
    }()
    
    init(tableView: UITableView,
         items: [CellConfigurator],
         footerConfigurator: PlaceTableFooterConfigurator,
         headerConfigurator: PlaceTableHeaderConfigurator) {
        self.tableView = tableView
        self.items = items
        self.headerConfigurator = headerConfigurator
        self.footerConfigurator = footerConfigurator
        super.init()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onActionEvent),
                                               name: CellAction.notificationName,
                                               object: nil)
    }
    
    @objc fileprivate
    func onActionEvent(notification: Notification) {
        if let eventData = notification.userInfo?["data"] as? CellActionEventData,
           let cell = eventData.cell as? UITableViewCell,
           let indexPath = self.tableView.indexPath(for: cell) {
            actionsProxy.invoke(action: eventData.action, cell: cell, configurator: items[indexPath.row])
        } else if let eventData = notification.userInfo?["data"] as? CellActionEventData {
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
        print(type(of: item).reuseIdentifier)
        
        return cell
    }

}

extension PlaceTableViewDirector: UITableViewDelegate {
       
    /* Handling TableView actions */
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

extension PlaceTableViewDirector {
    
    func configureHandlers() {
        
        let reviewsAction = CellAction.custom(PlaceUsefulButtonsTableViewCell.reviewsAction)
        
        self.actionsProxy.on(.didSelect) { (config: PlaceUsefulButtonsCellConfigurator, cell) in
            print("did select useful cell", config.item, cell)
        // swiftlint:disable:next unused_closure_parameter
        }.on(.willDisplay) { (config: PlaceImageTableCellConfigurator, cell) in
//            print("will display useful cell", c.item, cell)
        }.on(.didSelect) { (config: PlaceImageTableCellConfigurator, cell) in
            print("did select image cell", config.item, cell)
        // swiftlint:disable:next unused_closure_parameter
        }.on(.willDisplay) { (config: PlaceImageTableCellConfigurator, cell) in
//            print("will display image cell", c.item, cell)
        }.on(reviewsAction) { (config: PlaceUsefulButtonsCellConfigurator, cell) in
            print("Show reviews action", config.item, cell)
        }.on(CellAction.custom(PlaceUsefulButtonsTableViewCell.addToFavoriteAction)) { (config: PlaceUsefulButtonsCellConfigurator, cell) in
            print("add to favorites action", config.item, cell)
        }
    }
}

extension PlaceTableViewDirector: UIScrollViewDelegate {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceUsefulButtonsCellConfigurator.reuseIdentifier)!
//
//        if tableView.visibleCells.contains(cell) {
//            return
//        }
//
//        guard let indexPath = tableView.indexPathForRow(at: cell.center) else {
//            fatalError()
//        }
//        let item = items[indexPath.row]
//        var newItems = items
//        newItems.remove(at: indexPath.row)
//        newItems.insert(item, at: 0)
//        print(newItems)
//        items = newItems
//
//    }
    
}
