//
//  Filters.swift
//  PhotoApp
//
//  Created by Gloria on 14/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation
class Filters {
    var currentFilter: String!
    var name: String!
    var parameters: Array<Any>
    
    init(currentFilter: String,name: String, parameters: Array<Any>) {
    self.currentFilter = currentFilter
      self.name = name
      self.parameters = parameters
    }
}
