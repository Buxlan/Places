//
//  ReviewViewModel.swift
//  Places
//
//  Created by  Buxlan on 7/28/21.
//

import UIKit

typealias ReviewImageCellConfigurator =
    TableCellConfigurator<ReviewImageCell, Review>
typealias ReviewLabelCellConfigurator =
    TableCellConfigurator<ReviewLabelCell, Review>
typealias ReviewDescriptionCellConfigurator =
    TableCellConfigurator<ReviewDescriptionCell, Review>

class ReviewViewModel: NSObject {
    
    var review: Review {
        didSet {
            items = [
                ReviewImageCellConfigurator(item: review),
                ReviewLabelCellConfigurator(item: review),
                ReviewDescriptionCellConfigurator(item: review)
            ]
        }
    }
    var items: [CellConfigurator]
    let actionsProxy = CellActionProxy()
    var tableView: UITableView {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override init() {
        self.tableView = UITableView()
        self.review = Review.empty
        items = [
            ReviewImageCellConfigurator(item: review),
            ReviewLabelCellConfigurator(item: review),
            ReviewDescriptionCellConfigurator(item: review)
        ]
        
        super.init()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onActionEvent),
                                               name: CellAction.notificationName,
                                               object: nil)
        
    }
        
    init(review: Review, tableView: UITableView) {
        self.tableView = tableView
        self.review = review
        items = [
            ReviewImageCellConfigurator(item: review),
            ReviewLabelCellConfigurator(item: review),
            ReviewDescriptionCellConfigurator(item: review)
        ]
                
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onActionEvent),
                                               name: CellAction.notificationName,
                                               object: nil)
    }
    
    @objc
    private func onActionEvent(notification: Notification) {
        if let eventData = notification.userInfo?["data"] as? CellActionEventData,
           let cell = eventData.cell as? UITableViewCell,
           let indexPath = self.tableView.indexPath(for: cell) {
            actionsProxy.invoke(action: eventData.action, cell: cell, configurator: items[indexPath.row])
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension ReviewViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseIdentifier,
                                                 for: indexPath)
        item.configure(cell: cell)
        
        return cell
    }

}

extension ReviewViewModel: UITableViewDelegate {
       
    /* Handling TableView actions */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // no need to keep cell selected
//        tableView.deselectRow(at: indexPath, animated: true)
//        let cellConfigurator = items[indexPath.row]
//        guard let cell = tableView.cellForRow(at: indexPath) else {
//            fatalError()
//        }
//        self.actionsProxy.invoke(action: .didSelect, cell: cell, configurator: cellConfigurator)
        
//        tableView.deselectRow(at: indexPath, animated: true)
//        let item = viewModel.item(at: indexPath)
//        if let vc = UIViewController.instantiateViewController(withIdentifier: .review) as? ReviewViewController {
//            vc.place = item
//            vc.modalPresentationStyle = .pageSheet
//            present(vc, animated: true)
//        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellConfigurator = items[indexPath.row]
        self.actionsProxy.invoke(action: .willDisplay, cell: cell, configurator: cellConfigurator)
    }
}

extension ReviewViewModel {
    
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
