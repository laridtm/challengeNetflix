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
    let config: Realm.Configuration
    
    init(config: Realm.Configuration) {
        self.config = config
    }

    func add(movies: [Movie]) {
        let handler = HandlerDatabase(config: config)
        var moviesRealm: [MovieRealm] = []
        moviesRealm = movies.map { $0.toMovieRealm() }

        moviesRealm.forEach { movie in
            handler.add(object: movie)
        }
    }
}
