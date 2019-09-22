//
//  CustomFiltersEntity.swift
//  PhotoApp
//
//  Created by Gloria on 22/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation
import RealmSwift

class CustomFiltersEntity: Object {
    @objc dynamic var id = ""
    @objc dynamic var currentFilter = ""
    @objc dynamic var name = ""
    @objc dynamic var parameters: Double = 0.0
    override static func primaryKey() -> String?{
        return "id"
    }
    @objc dynamic var date = Date()
    
    convenience init(customFilters: CustomFilters) {
        self.init()
        self.id = customFilters.id
        self.currentFilter = customFilters.currentFilter
        self.name = customFilters.name
        self.parameters = customFilters.parameters
        self.date = customFilters.date
    }
    func customFiltersModel() -> CustomFilters{
        let model = CustomFilters(id: self.id, currentFilter: self.currentFilter, name: self.name, parameters: self.parameters, date: self.date)
        return model
    }
}
