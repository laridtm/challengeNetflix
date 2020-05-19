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
//    let database: HandlerDatabase
    let config: Realm.Configuration
    
    init(config: Realm.Configuration) {
//        self.database = HandlerDatabase(config: config)
        self.config = config
    }

    func addDB(movies: [Movie]) {
//        var movieRealm = MovieRealm()
//        movieRealm = movie.toMovieRealm()
//        database.addDB(object: movieRealm)
        let handler = HandlerDatabase(config: config)
        var moviesRealm: [MovieRealm] = []
        moviesRealm = movies.map { $0.toMovieRealm() }

        moviesRealm.forEach { movie in
            handler.addDB(object: movie)
        }
    }
}
