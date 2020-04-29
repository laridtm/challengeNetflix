//
//  MovieDatabase.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 15/04/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

class MovieDatabase {
    
    let realm: Realm
    
    init(config: Realm.Configuration) {
        do {
            self.realm = try Realm(configuration: config)
        } catch let error as NSError {
            print(error)
            self.realm = try! Realm()
        }
    }
    
//    func addFilmDB(movie: Movie) {
//
//        let movieRealm = MovieRealm()
//
//        movieRealm.id = movie.id
//        movieRealm.title = movie.title
//        movieRealm.year = movie.year
//        movieRealm.runtime = movie.runtime
//        movieRealm.metascore = movie.metascore
//        movieRealm.resolution = movie.resolution
//        movieRealm.hdr = movie.hdr
//
//        do {
//
//            try realm.write {
//                realm.add(movieRealm, update: .modified)
//            }
//
//        } catch let error as NSError {
//            print(error)
//        }
//
//    }
    
    func addFilmDB(object: Object) {
        
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
    
    func deleteFavFilm(id: String) {
        
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
