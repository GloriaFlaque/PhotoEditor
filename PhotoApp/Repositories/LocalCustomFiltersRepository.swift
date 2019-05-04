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
            let entities = try Realm().objects(CustomFiltersEntity.self).sorted(byKeyPath: "date", ascending: true)
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
            let entity = CustomFiltersEntity(id: a.id, date: a.date, filters: a.filters)
            try realm.write {
                realm.add(entity, update: true)
            }
        }
        catch {
            return false
        }
        return true
    }
    func delete(a: CustomFilters) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                let entitiyDelete = realm.objects(CustomFiltersEntity.self).filter("id == %@", a.id)
                realm.delete(entitiyDelete)
            }
        }
        catch{
            return false
        }
        return true
    }
}
