//
//  CustomFilters.swift
//  PhotoApp
//
//  Created by Gloria on 21/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation
class CustomFilters {
    var id: String!
    var currentFilter: String!
    var name: String!
    var parameters: Double!
    var date: Date!
    
    init(id: String, currentFilter: String,name: String, parameters: Double, date: Date) {
        self.id = id
        self.currentFilter = currentFilter
        self.name = name
        self.parameters = parameters
        self.date = date
    }
}
