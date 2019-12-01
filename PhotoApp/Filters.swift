//
//  Filters.swift
//  PhotoApp
//
//  Created by Gloria on 14/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation
class Filters {
    var id: String!
    var currentFilter: String!
    var name: String!
    var parameters: Double!
    var selected: Bool!
    
    init(id: String, currentFilter: String,name: String, parameters: Double, selected: Bool) {
      self.id = id
      self.currentFilter = currentFilter
      self.name = name
      self.parameters = parameters
      self.selected = selected
    }
}
