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
    var headerConfigurator: PlaceTableHeaderConfigurator
    
    lazy var tableFooterView: UIView = {
        return PlaceTableViewFooter()
    }()
    
    lazy var tableHeaderView: UIView = {
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
        print(type(of: item).reuseIdentifier)
        
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


/* Handlers */
extension PlaceTableViewDirector {
    
    func configureHandlers() {
        
        self.actionsProxy.on(.didSelect) { (c :PlaceUsefulButtonsCellConfigurator, cell) in
            print("did select useful cell", c.item, cell)
        }.on(.willDisplay) { (c: PlaceUsefulButtonsCellConfigurator, cell) in
//            print("will display useful cell", c.item, cell)
        }.on(.didSelect) { (c: PlaceImageTableCellConfigurator, cell) in
            print("did select image cell", c.item, cell)
        }.on(.willDisplay) { (c: PlaceImageTableCellConfigurator, cell) in
//            print("will display image cell", c.item, cell)
        }.on(CellAction.custom(PlaceUsefulButtonsTableViewCell.reviewsAction)) { (c: PlaceUsefulButtonsCellConfigurator, cell) in
            print("Show reviews action", c.item, cell)
        }.on(CellAction.custom(PlaceUsefulButtonsTableViewCell.addToFavoriteAction)) { (c: PlaceUsefulButtonsCellConfigurator, cell) in
            print("add to favorites action", c.item, cell)
        }.on(CellAction.custom(PlaceTableViewFooter.placePlaySoundAction)) { [self] (object: Place, view: UIView) in
            print("Tapped play sound", object, view)
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaceUsefulButtonsCellConfigurator.reuseIdentifier)!
            if let currentIndexPath = self.tableView.indexPathForRow(at: cell.center) {
                guard let newIndexPath = self.tableView.indexPathsForVisibleRows?.first else {
                    fatalError()
                }
                if currentIndexPath != newIndexPath {
                    tableView.beginUpdates()
                    self.tableView.moveRow(at: currentIndexPath, to: newIndexPath)
                    tableView.endUpdates()
                    let item = items[currentIndexPath.row]
                    for i in (newIndexPath.row+1...currentIndexPath.row).reversed() {
                        items[i] = items[i-1]
                    }
                    items[newIndexPath.row] = item
                }
            }
        }.on(CellAction.custom(PlaceTableViewHeader.tappedLogoAction)) { (object: Place, view: UIView) in
            print("Tapped play sound", object, view)
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
