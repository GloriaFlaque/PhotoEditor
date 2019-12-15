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
    @objc dynamic var id = ""
    @objc dynamic var currentFilter = ""
    @objc dynamic var name = ""
    @objc dynamic var parameters: Double = 0.0
    
    override static func primaryKey() -> String?{
        return "id"
    }
    convenience init(filters: Filters) {
        self.init()
        self.id = filters.id
        self.currentFilter = filters.currentFilter
        self.name = filters.name
        self.parameters = filters.parameters
    }
    func filtersModel() -> Filters {
        let model = Filters(id: self.id, currentFilter: self.currentFilter, name: self.name, parameters: self.parameters)
        return model
    }
}
