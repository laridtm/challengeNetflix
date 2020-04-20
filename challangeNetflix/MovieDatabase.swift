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
    
    func addFilmDB(movie: Movie) {
        
        let movieRealm = MovieRealm()
        
        movieRealm.id = movie.id
        movieRealm.title = movie.title
        movieRealm.year = movie.year
        movieRealm.runtime = movie.runtime
        movieRealm.metascore = movie.metascore
        movieRealm.resolution = movie.resolution
        movieRealm.hdr = movie.hdr
        
        do {
            
            try realm.write {
                realm.add(movieRealm, update: .modified)
            }
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func retrieveAllObjects() -> [MovieRealm] {
        
        var allObjects: [MovieRealm] = []
        
//        do {
            
            var realmResults = realm.objects(MovieRealm.self)
            
            for movieRealm in realmResults {
                allObjects.append(movieRealm)
            }
//
//        } catch let error as NSError {
//            print(error)
//        }
        
        return allObjects
    }
    
}
