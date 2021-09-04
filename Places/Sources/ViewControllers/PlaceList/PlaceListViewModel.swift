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
                _sections.append(section)
            }
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
    
    func update() {
        
    }
    
    // MARK: - Private
    private var _sections: [TableViewSection] = [TableViewSection]()
    
}

extension PlaceListViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionCell.reuseIdentifier, for: indexPath)
        
        if let reviewCell = cell as? ReviewCollectionCell {
            reviewCell.configureInterface()
            let review = Review.empty
            reviewCell.configure(data: review)
        }
        cell.backgroundColor = .blue
        
        return cell
    }    
}
