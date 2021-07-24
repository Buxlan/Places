//
//  PlaceListViewModel.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import UIKit

struct TableViewSection: Equatable {
    let name: String?
    let items: [CellConfigurator]
    
    static func == (lhs: TableViewSection,
                    rhs: TableViewSection) -> Bool {
        return lhs.name == rhs.name
    }
}

class PlaceListViewModel: NSObject {
 
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
        if let conf = _sections[indexPath.section].items[indexPath.row] as? PlaceListCellConfigurator {
            return conf.item
        }
        return Place.empty
    }
    
    private func generateSections() {
        let pcon = PlaceController.shared
        if let collection1 = pcon.collection(with: .top),
           let collection2 = pcon.collection(with: .new) {
            let collections = [collection1, collection2]
            for collection in collections {
                var items = [CellConfigurator]()
                for place in collection.items {
                    let con = PlaceListCellConfigurator(item: place, cellHeight: UITableView.automaticDimension)
                    items.append(con)
                }
                let section = TableViewSection(name: collection.name, items: items)
                _sections.append(section)
            }
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
    
    // MARK: - Private
    private var _sections: [TableViewSection] = [TableViewSection]()
    
}

extension PlaceListViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return items(at: section).count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
                
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceListCellConfigurator.reuseIdentifier,
                                                 for: indexPath)
        
        if item.isInterfaceConfigured == false {
            item.configureInterface(cell: cell)
        }
        item.configure(cell: cell)        
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return _sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return _sections[section].name
    }
        
}
