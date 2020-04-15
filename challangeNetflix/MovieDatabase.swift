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
            
            let realm = try Realm()
            
            try realm.write {
                realm.add(movieRealm, update: .modified)
            }
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
}
