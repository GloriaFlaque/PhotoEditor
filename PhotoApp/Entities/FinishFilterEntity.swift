//
//  FinishFilterEntity.swift
//  PhotoApp
//
//  Created by Gloria on 12/5/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation
import RealmSwift

class FinishFilterEntity: Object {
    @objc dynamic var id = ""
    var filters: List <FiltersEntity> = List <FiltersEntity>()
    @objc dynamic var date = Date()
    override static func primaryKey() -> String?{
        return "id"
    }
    
    convenience init(id: String, date: Date, filters:[Filters]) {
        self.init()
        self.id = id
        self.date = date
        for filter in filters{
            self.filters.append(FiltersEntity(filters: filter))
        }
    }
    
    func finishFiltersModel() -> FinishFilter{
        var filtersArray: [Filters] = []
        for filter in filters{
            filtersArray.append(filter.filtersModel())
        }
        let model = FinishFilter(id: self.id, filters: filtersArray, date: self.date)
        return model
    }
}
