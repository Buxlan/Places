//
//  PlaceListTableViewDataModel.swift
//  Places
//
//  Created by  Buxlan on 7/21/21.
//

import UIKit

struct TableViewSection: Equatable {
    let name: String?
    let collection: PlaceCollection
    
    static func == (lhs: TableViewSection,
                    rhs: TableViewSection) -> Bool {
        return lhs.name == rhs.name
    }
}

class PlaceListDataModel {
    
    // MARK: - Public
    var sections: [TableViewSection] {
        return _sections
    }
    
    func items(in section: Int) -> [Place] {
        guard section > 0 && section < sections.count else {
            fatalError()
        }
        return sections[section].collection.items
    }
    
    init() {
        let pcon = PlaceController.shared
        if let collection1 = pcon.collection(with: .top),
           let collection2 = pcon.collection(with: .new) {
            let collections = [collection1, collection2]
            let sections = collections.map { (collection) -> TableViewSection in
                return TableViewSection(name: collection.name, collection: collection)
            }
            _sections = sections
        } else {
            fatalError()
        }        
    }
    
    init(sections: [TableViewSection]) {
        self._sections = sections
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
    private var _sections: [TableViewSection]
    
}
