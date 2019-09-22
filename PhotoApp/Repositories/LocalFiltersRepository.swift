//
//  LocalFiltersRepository.swift
//  PhotoApp
//
//  Created by Gloria on 22/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation
import RealmSwift

class LocalFiltersRepository: NSObject{
    func getAll() -> [Filters] {
        var tasks : [Filters] = []
        do {
            let entities = try Realm().objects(FiltersEntity.self).sorted(byKeyPath: "id", ascending: true)
            for entity in entities {
                let model = entity.filtersModel()
                tasks.append(model)
            }
        }
        catch let error as NSError {
            print("Error en el getAll Tasks:", error.description)
        }
        return tasks
    }
    
    func delete(a: Filters) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                let entitiyDelete = realm.objects(FiltersEntity.self).filter("name == %@", a.name)
                realm.delete(entitiyDelete)
            }
        }
        catch{
            return false
        }
        return true
    }
    func create(a: Filters) -> Bool {
        do {
            let realm = try Realm()
            let entity = FiltersEntity(filters: a)
            try realm.write {
                realm.add(entity, update: true)
            }
        }
        catch {
            return false
        }
        return true
    }
    func deleteAll() -> Bool {
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
