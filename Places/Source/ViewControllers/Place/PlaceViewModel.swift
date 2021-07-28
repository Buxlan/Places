//
//  PlaceViewModel.swift
//  Places
//
//  Created by  Buxlan on 5/20/21.
//

import UIKit

typealias PlaceImageTableCellConfigurator =
    TableCellConfigurator<PlaceImageCell, Place>
typealias PlaceLabelTableCellConfigurator =
    TableCellConfigurator<PlaceLabelCell, Place>
typealias PlaceUsefulButtonsCellConfigurator =
    TableCellConfigurator<PlaceUsefulButtonsTableViewCell, Place>
typealias PlaceDescriptionTableCellConfigurator =
    TableCellConfigurator<PlaceDescriptionCell, Place>
typealias PlaceMapTableCellConfigurator =
    TableCellConfigurator<PlaceMapTableViewCell, Place>

class PlaceViewModel {
    
    let place: Place
    var items: [CellConfigurator]
    
    init(place: Place) {
        self.place = place
        items = [
            PlaceLabelTableCellConfigurator(item: place),
            PlaceImageTableCellConfigurator(item: place),
            PlaceUsefulButtonsCellConfigurator(item: place),
            PlaceDescriptionTableCellConfigurator(item: place),
            PlaceMapTableCellConfigurator(item: place)
        ]
    }
    
}
