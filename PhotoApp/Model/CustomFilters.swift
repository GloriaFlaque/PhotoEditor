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
    var filters: [Filters] = []
    var date: Date!
    
    init(id: String, filters: [Filters], date: Date) {
        self.id = id
        self.filters = filters
        self.date = date
    }
}
