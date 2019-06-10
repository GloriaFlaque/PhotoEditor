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
    @objc dynamic var parameters: Double = 0.0
    //var parameters: [Any] = []
    
    override static func primaryKey() -> String?{
        return "currentFilter"
    }
    convenience init(filters: Filters) {
        self.init()
        self.currentFilter = filters.currentFilter
        self.name = filters.name
        self.parameters = filters.parameters
        /*for parameter in parameters{
            self.parameters.append(parameter)
        }*/
    }
    func filtersModel() -> Filters {
        /*var parametersArray: [Any] = []
        for parameter in parameters{
            parametersArray.append(parameter)
        }*/
        let model = Filters(currentFilter: self.currentFilter, name: self.name, parameters: self.parameters)
        return model
    }
}
