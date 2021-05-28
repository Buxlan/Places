//
//  PlaceViewModel.swift
//  Places
//
//  Created by  Buxlan on 5/20/21.
//

import UIKit

class PlaceViewModel {
    
    let place: Place
    var items: [CellConfigurator]
    
    init(place: Place) {
        self.place = place
        items = [
            PlaceLabelTableCellConfigurator(item: place, cellHeight: UITableView.automaticDimension),
            PlaceImageTableCellConfigurator(item: place, cellHeight: 250),
            PlaceUsefulButtonsCellConfigurator(item: place, cellHeight: UITableView.automaticDimension),
            PlaceDescriptionTableCellConfigurator(item: place, cellHeight: UITableView.automaticDimension),
            PlaceMapTableCellConfigurator(item: place, cellHeight: 250)
        ]
    }
    
}
