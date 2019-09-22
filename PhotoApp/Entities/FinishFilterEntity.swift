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
    //var customFilters: List <CustomFiltersEntity> = List <CustomFiltersEntity>()
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
        /*for customFilters in customFilters{
            self.customFilters.append(CustomFiltersEntity(value: customFilters))
        }*/
    }
    
    func finishFiltersModel() -> FinishFilter{
        /*var customFiltersArray: [CustomFilters] = []
        for customFilters in customFilters{
            customFiltersArray.append(customFilters.customFiltersModel())
        }*/
        var filtersArray: [Filters] = []
        for filter in filters{
            filtersArray.append(filter.filtersModel())
        }
        let model = FinishFilter(id: self.id, filters: filtersArray, date: self.date)
        return model
    }
}
