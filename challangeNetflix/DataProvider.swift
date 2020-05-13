//
//  DataProvider.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 13/05/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

class DataProvider {
    let database: HandlerDatabase
    
    init(config: Realm.Configuration) {
        self.database = HandlerDatabase(config: config)
    }
    
    func consultDatabase(movie: Movie) -> Object? {
        let retrievedObject = database.retrieveObject(id: movie.id)
        return retrievedObject
    }
    
    func addDatabase(movie: Movie) {
        let movieFavRealm = MovieFavRealm()
        movieFavRealm.id = movie.id
        database.addDB(object: movieFavRealm)
    }
    
    func deleteDB(object: Object) {
        database.deleteDB(object: object)
    }
}
