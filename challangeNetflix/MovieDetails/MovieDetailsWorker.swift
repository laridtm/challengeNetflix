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
    var movie: Movie { get }
    func consultDatabase() -> Object?
    func addDatabase()
    func deleteDB(object: Object)
}

class MovieDetailsWorker: MovieDetailsWorkerProtocol {
    //worker -> dataprovider -> handlerdatabase
    //init worker movie e dataprovider
    var movie: Movie
    let dataProvider: DataProvider
    
    init(movie: Movie, dataProvider: DataProvider) {
        self.movie = movie
        self.dataProvider = dataProvider
    }

    func consultDatabase() -> Object? {
        let retrievedObject = dataProvider.consultDatabase(movie: movie)
        return retrievedObject
    }
    
    func addDatabase() {
        dataProvider.addDatabase(movie: movie)
    }
    
    func deleteDB(object: Object) {
        dataProvider.deleteDB(object: object)
    }
}
