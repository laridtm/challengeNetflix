//
//  MovieListDataProvider.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 14/05/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

class MovieListDataProvider {
    let database: HandlerDatabase
    
    init(config: Realm.Configuration) {
        self.database = HandlerDatabase(config: config)
    }

    func addDB(movie: Movie) {
        var movieRealm = MovieRealm()
        movieRealm = movie.toMovieRealm()
        database.addDB(object: movieRealm)
    }
}
