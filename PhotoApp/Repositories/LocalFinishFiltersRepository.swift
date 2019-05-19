//
//  LocalFinishFiltersRepository.swift
//  PhotoApp
//
//  Created by Gloria on 12/5/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation
import RealmSwift

class LocalFinishFiltersRepository: NSObject {
    func getAll() -> [FinishFilter] {
        var tasks : [FinishFilter] = []
        do {
            let entities = try Realm().objects(FinishFilterEntity.self).sorted(byKeyPath: "id", ascending: true)
            for entity in entities {
                let model = entity.finishFiltersModel()
                tasks.append(model)
            }
        }
        catch let error as NSError {
            print("Error en el getAll Tasks:", error.description)
        }
        return tasks
    }
    func create(a: FinishFilter) -> Bool {
        do {
            let realm = try Realm()
            let entity = FinishFilterEntity(id: a.id, date: a.date, customFilters: a.customFilters)
            try realm.write {
                realm.add(entity, update: true)
            }
        }
        catch {
            return false
        }
        return true
    }
    func delete(a: FinishFilter) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                let entitiyDelete = realm.objects(FinishFilterEntity.self).filter("id == %@", a.id)
                realm.delete(entitiyDelete)
            }
        }
        catch{
            return false
        }
        return true
    }
}
