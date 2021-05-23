//
//  PlaceViewController.swift
//  Places
//
//  Created by  Buxlan on 5/19/21.
//

import UIKit

class PlaceViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let place = PlaceController().collections[0].places[0]
    var viewModel: PlaceViewModel! = nil
    lazy var tableDirector: PlaceTableViewDirector = {
        return PlaceTableViewDirector(tableView: tableView,
                                      items: viewModel.items,
                                      footerConfigurator: PlaceTableFooterConfigurator(item: place))
    }()
    
    override func viewDidLoad() {
        
        viewModel = PlaceViewModel(place: place)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        addHandlers()
    }
    
    private func addHandlers() {
        self.tableDirector.actionsProxy.on(.didSelect) { (c :PlaceUsefulButtonsCellConfigurator, cell) in
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
        }.on(CellAction.custom(PlaceTableViewFooter.placePlaySoundAction)) { (object: Place, view: UIView) in
            print("Tapped play sound", object, view)
        }
//        .on(CellAction.custom(PlaceTableViewFooter.placePlaySoundAction)) { (place: Place, view) in
//            print("tapped Play", place, view)
//        }
    }
    
}
