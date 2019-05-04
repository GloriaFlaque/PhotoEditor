//
//  FiltersEntity.swift
//  PhotoApp
//
//  Created by Gloria on 22/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation
import RealmSwift

class FiltersEntity: Object {
    @objc dynamic var currentFilter = ""
    @objc dynamic var name = ""
    var parameters: Array<Any> = []
    
    override static func primaryKey() -> String?{
        return "currentFilter"
    }
    convenience init(filters: Filters) {
        self.init()
        self.currentFilter = filters.currentFilter
        self.name = filters.name
        self.parameters = filters.parameters
    }
    func filtersModel() -> Filters {
        let model = Filters(currentFilter: self.currentFilter, name: self.name, parameters: self.parameters)
        model.currentFilter = self.currentFilter
        model.name = self.name
        model.parameters = self.parameters
        return model
    }
}
