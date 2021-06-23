//
//  PlacesController.swift
//  Places
//
//  Created by  Buxlan on 5/7/21.
//

import Foundation

class PlaceController {
    
    struct PlaceCollection: Hashable {
        let title: String
        let places: [Place]
        
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    var collections: [PlaceCollection] {
        return _collections
    }
    
    init() {
        generateCollections()
    }
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
        _collections = [
            PlaceCollection(title: "Популярные за неделю", places: [
                Place(title: "Невский проспект", category: "Category 1", description: PlaceController.description),
                Place(title: "Parnas", category: "Category 2", description: "1"),
                Place(title: "Hermitage", category: "Category 3", description: PlaceController.description),
                Place(title: "Петергоф", category: "Category 3", description: PlaceController.description),
                Place(title: "Площадь восстания", category: "Category 3", description: PlaceController.description)
            ]),
            PlaceCollection(title: "Новинки!", places: [
                Place(title: "Vas'ka", category: "Category 1", description: PlaceController.description),
                Place(title: "Prosvet", category: "Category 2", description: PlaceController.description),
                Place(title: "Devyatkino", category: "Category 3", description: PlaceController.description)
            ]),
        ]
    }
}
