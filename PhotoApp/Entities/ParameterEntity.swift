//
//  ParameterEntity.swift
//  PhotoApp
//
//  Created by Gloria on 5/6/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation
import RealmSwift

class ParameterEntity:  Object {
    var parameters: Any!
    convenience init(parameter: Parameters) {
        self.init()
        self.parameters = parameter.parameter
    }
    func parammetersModel() -> Parameters {
        let model = Parameters(parameter: self.parameters)
        return model
    }
}
