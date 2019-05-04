//
//  Repository.swift
//  PhotoApp
//
//  Created by Gloria on 22/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation
protocol Repository {
    associatedtype T
    func getAll() -> [T]
    func get(identifier: String) -> T?
    func create(a: T) -> Bool
    func update(a: T) -> Bool
    func delete(a: T) -> Bool
}
