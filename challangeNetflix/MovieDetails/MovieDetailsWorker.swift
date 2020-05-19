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
    var movie: Movie
    let dataProviderDetails: MovieDetailsDataProvider
    
    init(movie: Movie, dataProvider: MovieDetailsDataProvider) {
        self.movie = movie
        self.dataProviderDetails = dataProvider
    }

    func consultDatabase() -> Object? {
        let retrievedObject = dataProviderDetails.consultDatabase(movie: movie)
        return retrievedObject
    }
    
    func addDatabase() {
        dataProviderDetails.addDatabase(movie: movie)
    }
    
    func deleteDB(object: Object) {
        dataProviderDetails.deleteDB(object: object)
    }
}
