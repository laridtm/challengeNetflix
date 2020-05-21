//
//  DataProvider.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 13/05/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

class MovieDetailsDataProvider {
    let database: HandlerDatabase
    
    init(config: Realm.Configuration) {
        self.database = HandlerDatabase(config: config)
    }
    
    func retrievedObject(movie: Movie) -> Object? {
        let retrievedObject = database.retrieveObject(id: movie.id)
        return retrievedObject
    }
    
    func add(movie: Movie) {
        let movieFavRealm = MovieFavRealm()
        movieFavRealm.id = movie.id
        database.add(object: movieFavRealm)
    }
    
    func delete(object: Object) {
        database.delete(object: object)
    }
}
