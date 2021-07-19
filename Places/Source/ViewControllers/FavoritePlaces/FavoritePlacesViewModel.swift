//
//  FavoritePlacesViewModel.swift
//  Places
//
//  Created by  Buxlan on 6/15/21.
//

import Foundation
import UIKit

class FavoritePlacesViewModel {
    
    var items: [Place]
    weak var tableView: UITableView?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        items = [Place]()
    }
    
    func updateData(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                sleep(4)
            }
            self?.items = PlaceController().collections[0].places
            
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
                completion()
            }
            Log(text: "Data was loaded and table view was reloaded", object: self?.tableView)            
        }
    }
    
}
