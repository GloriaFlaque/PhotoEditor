//
//  LocalCustomFiltersRepository.swift
//  PhotoApp
//
//  Created by Gloria on 22/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation
import RealmSwift

class LocalCustomFiltersRepository: NSObject{
    func getAll() -> [CustomFilters] {
        var tasks : [CustomFilters] = []
        do {
            let entities = try Realm().objects(CustomFiltersEntity.self).sorted(byKeyPath: "id", ascending: true)
            for entity in entities {
                let model = entity.customFiltersModel()
                tasks.append(model)
            }
        }
        catch let error as NSError {
            print("Error en el getAll Tasks:", error.description)
        }
        return tasks
    }
    func create(a: CustomFilters) -> Bool {
        do {
            let realm = try Realm()
            let entity = CustomFiltersEntity(customFilters: a)
            try realm.write {
                realm.add(entity, update: .all)
            }
        }
        catch {
            return false
        }
        return true
    }
    func delete() -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        }
        catch{
            return false
        }
        return true
    }
}
