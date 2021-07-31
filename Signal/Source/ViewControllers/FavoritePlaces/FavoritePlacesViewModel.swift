//
//  FavoritePlacesViewModel.swift
//  Places
//
//  Created by  Buxlan on 6/15/21.
//

import Foundation
import UIKit

typealias FavoriteListCellConfigurator = TableCellConfigurator<FavoritePlaceCell, Place>

class FavoritePlacesViewModel: NSObject {
    
    // MARK: - Public
    var sections: [TableViewSection] {
        return _sections
    }
    
    override init() {
        super.init()
        generateSections()
    }
    
    init(sections: [TableViewSection]) {
        super.init()
        self._sections = sections
    }
    
    func items(at sectionIndex: Int) -> [CellConfigurator] {
        guard sectionIndex >= 0 && sectionIndex < sections.count else {
            fatalError()
        }
        return sections[sectionIndex].items
    }
    
    func item(at indexPath: IndexPath) -> Place {
        guard indexPath.section >= 0 && indexPath.section < sections.count else {
            fatalError()
        }
        if let conf = _sections[indexPath.section].items[indexPath.row] as? FavoriteListCellConfigurator {
            return conf.item
        }
        return Place.empty
    }
    
    private func generateSections() {
        let pcon = PlaceController.shared
        if let collection = pcon.collection(with: .favorite) {
            var items = [CellConfigurator]()
            for place in collection.items {
                let con = FavoriteListCellConfigurator(item: place)
                items.append(con)
            }
            let section = TableViewSection(name: collection.name, items: items)
            _sections.append(section)
        } else {
            fatalError()
        }
    }
    
    func insert(section: TableViewSection, at index: Int) {
        _sections.insert(section, at: index)
    }
    
    func append(section: TableViewSection) {
        _sections.append(section)
    }
    
    func remove(section: TableViewSection) {
        if let index = _sections.firstIndex(where: { $0 == section }) {
            _sections.remove(at: index)
        }
    }
    
//    func update(completion: @escaping () -> Void) {
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            do {
//                sleep(4)
//            }
//            self?.items = PlaceController().collections[0].items
//            
//            DispatchQueue.main.async {
//                self?.tableView?.reloadData()
//                completion()
//            }
//            Log(text: "Data was loaded and table view was reloaded", object: self?.tableView)
//        }
//    }
    
    // MARK: - Private
    private var _sections: [TableViewSection] = [TableViewSection]()
    
}

extension FavoritePlacesViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return items(at: section).count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
                
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritePlaceCell.reuseIdentifier,
                                                 for: indexPath)
        
        if let castedCell = cell as? FavoritePlaceCell,
           castedCell.isInterfaceConfigured == false {
            item.configureInterface(cell: cell, with: nil)
        }
        item.configure(cell: cell)
//        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
//        cell.clipsToBounds = true
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return _sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return _sections[section].name
    }
          
}
