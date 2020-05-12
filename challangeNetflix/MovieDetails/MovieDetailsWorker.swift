//
//  MovieDetailsWorker.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 12/05/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

protocol MovieDetailsWorkerProtocol: class {
//    func manageFavorites()
    func consultDatabase(movie: Movie) -> Object?
    func addDatabase(movie: Movie)
    func deleteDB(object: Object)
}

var handlerDataBase: HandlerDatabase = HandlerDatabase(config: Realm.Configuration())

class MovieDetailsWorker: MovieDetailsWorkerProtocol {
//    func manageFavorites() {
//        <#code#>
//    }
    
    func consultDatabase(movie: Movie) -> Object? {
        let retrievedObject = handlerDataBase.retrieveObject(id: movie.id)
        return retrievedObject
    }
    
    func addDatabase(movie: Movie) {
        let movieFavRealm = MovieFavRealm()
        movieFavRealm.id = movie.id
        handlerDataBase.addDB(object: movieFavRealm)
    }
    
    func deleteDB(object: Object) {
        handlerDataBase.deleteDB(object: object)
    }
}
