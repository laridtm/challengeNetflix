//
//  MovieDatabase.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 15/04/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

class HandlerDatabase {
    let realm: Realm
    
    init(config: Realm.Configuration) {
        do {
            self.realm = try Realm(configuration: config)
        } catch let error as NSError {
            print(error)
            self.realm = try! Realm()
        }
    }
    
    func addDB(object: Object) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func retrieveAllObjects(type: Object.Type) -> [Object] {
        var allObjects: [Object] = []
        var realmResults = realm.objects(type)
        
        for object in realmResults {
            allObjects.append(object)
        }
        return allObjects
    }
    
    func retrieveObject(id: String) -> Object? {
        return realm.object(ofType: MovieFavRealm.self, forPrimaryKey: id)
    }
    
    func deleteDB(object: Object) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
