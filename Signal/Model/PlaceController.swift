//
//  PlacesController.swift
//  Places
//
//  Created by  Buxlan on 5/7/21.
//

import Foundation

enum CollectionType {
    case top
    case favorite
    case nearest
    case new
    case ancient
    case nearToCenter
}

struct PlaceCollection: Hashable, Equatable {
        
    let name: String
    let collectionType: CollectionType
    let items: [Place]
    
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: PlaceCollection,
                    rhs: PlaceCollection) -> Bool {
        return lhs.name == rhs.name
            && lhs.collectionType == rhs.collectionType
    }
}

class PlaceController {
    
    static let shared = PlaceController()
    
    // MARK: - Public
    var collections: [PlaceCollection] {
        return _collections
    }
    
    func collection(with type: CollectionType) -> PlaceCollection? {
        let item = _collections.first(where: {$0.collectionType == type})
        return item
    }
    
    init() {
        generateCollections()
    }
    
    func insert(collection: PlaceCollection, at index: Int) {
        _collections.insert(collection, at: index)
    }
    
    func append(collection: PlaceCollection) {
        _collections.append(collection)
    }
    
    func remove(collection: PlaceCollection) {
        if let index = _collections.firstIndex(where: { $0.name == collection.name }) {
            _collections.remove(at: index)
        }
    }
    
    // MARK: - Public
    fileprivate var _collections = [PlaceCollection]()
    
}

extension PlaceController {
    
    // swiftlint:disable line_length
    fileprivate static let description = """
                        Прогулка-экскурсия по Невскому проспекту — пожалуй, второе по важности мероприятие, которое обязательно надо совершить во время визита в Санкт-Петербург. Здесь много достопримечательностей и мест, связанных с историей, но также это променад, на который петербуржцы и туристы выходят себя "себя показать и других посмотреть". Кроме того, здесь много магазинов, кафе и ресторанов, поэтому прогулку лучше запланировать на вечер.
                      
                        Нева в центре Санкт-Петербурга делает резкий поворот, и проспект получил свое название, потому что идет от берега Невы у Адмиралтейства до берега Невы у Александро-Невской лавры.

                        Строительство проспекта начали еще при Петре I, причем одновременно с двух сторон — от Лавры и от Адмиралтейства. Встретились две команды строителей в районе нынешней площади Восстания (там, где находится Московский вокзал и одноименная станция метро). И тут выяснилось, что проспект оказался кривым — с изломом в месте встречи.

                      Самая центральная часть Невского — от Адмиралтейства до площади Восстания. Тут находятся главные достопримечательности и красивые места. Часть проспекта после площади Восстания в обиходе называют Старо-Невским, хотя на картах он все равно "Невский". Здесь уже почти нет интересных мест, разве что Александро-Невская лавра.
                      """
    // swiftlint:enable line_length
    
    private func generateCollections() {
        
        let topCol = PlaceCollection(name: "Популярные за неделю",
                                     collectionType: .top,
                                     items: [
                                        Place(title: "Невский проспект", category: "Category 1", description: PlaceController.description),
                                        Place(title: "Parnas", category: "Category 2", description: "1"),
                                        Place(title: "Hermitage", category: "Category 3", description: PlaceController.description),
                                        Place(title: "Петергоф", category: "Category 3", description: PlaceController.description),
                                        Place(title: "Площадь восстания", category: "Category 3", description: PlaceController.description)
                                     ])
        
        let newCol = PlaceCollection(name: "Новинки!",
                                     collectionType: .new,
                                     items: [
                                        Place(title: "Vas'ka", category: "Category 1", description: PlaceController.description),
                                        Place(title: "Prosvet", category: "Category 2", description: PlaceController.description),
                                        Place(title: "Devyatkino", category: "Category 3", description: PlaceController.description)
                                     ])
        
        let favCol = PlaceCollection(name: "Избранные!",
                                     collectionType: .favorite,
                                     items: [
                                        Place(title: "Vas'ka", category: "Category 1", description: PlaceController.description),
                                        Place(title: "Prosvet", category: "Category 2", description: PlaceController.description),
                                        Place(title: "Ozerki", category: "Category 3", description: PlaceController.description)
                                     ])
        
        _collections = [topCol, newCol, favCol]
    }
}
