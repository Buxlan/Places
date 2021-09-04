//
//  PlaceListViewModel.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import UIKit

typealias PlaceListCellConfigurator
    = TableCellConfigurator<PlaceListCell, Place>
typealias PlaceReviewCellConfigurator
    = CollectionCellConfigurator<ReviewCollectionCell, Review>

struct TableViewSection: Equatable {
    let name: String?
    let icon: UIImage?
    var items: [CellConfigurator] = [CellConfigurator]()
    
    static func == (lhs: TableViewSection,
                    rhs: TableViewSection) -> Bool {
        return lhs.name == rhs.name
    }
}

class PlaceListViewModel: NSObject {    
    
    var tableViewSections: [TableViewSection] {
        return _tableViewSections
    }
    private var _tableViewSections: [TableViewSection] = [TableViewSection]()
    
    override init() {
        super.init()
        generateSections()
    }
    
    init(sections: [TableViewSection]) {
        super.init()
        self._tableViewSections = sections
    }
    
    func items(at sectionIndex: Int) -> [CellConfigurator] {
        guard sectionIndex >= 0 && sectionIndex < tableViewSections.count else {
            fatalError()
        }
        return tableViewSections[sectionIndex].items
    }
    
    func item(at indexPath: IndexPath) -> Place {
        guard indexPath.section >= 0 && indexPath.section < tableViewSections.count else {
            fatalError()
        }
        if let conf = _tableViewSections[indexPath.section].items[indexPath.row] as? PlaceListCellConfigurator {
            return conf.item
        }
        return Place.empty
    }
    
    private func generateSections() {
        let pcon = PlaceController.shared
        
        let categories: [CollectionType] = [
            .top,
            .new,
            .favorite,
            .recent,
            .streetArt,
            .recent,
            .streetArt
        ]
        
        for category in categories {
            if let collection = pcon.collection(with: category) {
                var items = [CellConfigurator]()
                for place in collection.items {
                    let con = PlaceListCellConfigurator(item: place)
                    items.append(con)
                }
                let section = TableViewSection(name: collection.name, icon: collection.icon, items: items)
                _tableViewSections.append(section)
            }
        }
    }
    
    func insert(section: TableViewSection, at index: Int) {
        _tableViewSections.insert(section, at: index)
    }
    
    func append(section: TableViewSection) {
        _tableViewSections.append(section)
    }
    
    func remove(section: TableViewSection) {
        if let index = _tableViewSections.firstIndex(where: { $0 == section }) {
            _tableViewSections.remove(at: index)
        }
    }
    
    func update() {
        
    }
    
}
