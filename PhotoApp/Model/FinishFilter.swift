//
//  FinishFilter.swift
//  PhotoApp
//
//  Created by Gloria on 12/5/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation
class FinishFilter {
    var id: String!
    var customFilters: [CustomFilters] = []
    var date: Date!
    
    init(id: String, customFilters: [CustomFilters], date: Date) {
        self.id = id
        self.customFilters = customFilters
        self.date = date
    }
}
