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
    
    func retrieveAllObjects() -> [MovieRealm] {
        
        var allObjects: [MovieRealm] = []
        
        var realmResults = realm.objects(MovieRealm.self)
        
        for movieRealm in realmResults {
            allObjects.append(movieRealm)
        }
        
        return allObjects
    }
    
    func favExist (id: String) -> Bool {
        
        do {
            
            let realm = try Realm()
            
            return realm.object(ofType: MovieFavRealm.self, forPrimaryKey: id) != nil
            
        } catch let error as NSError {
            print(error)
        }
        
        return false
    }
    
    
    func deleteFav (id: String) {
        
        do {
            
            let realm = try Realm()
            
            guard let object = realm.object(ofType: MovieFavRealm.self, forPrimaryKey: id) else {
                return
            }
            
            do {
                try realm.write {
                    realm.delete(object)
                }
            } catch let error as NSError {
                print(error)
            }
            
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
}
