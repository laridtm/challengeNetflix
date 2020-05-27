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
    func retrievedMovie() -> Object?
    func add(movie: Movie)
    func delete(object: Object)
    func showTrailler()
}

class MovieDetailsWorker: MovieDetailsWorkerProtocol {
    var movie: Movie
    let dataProviderDetails: MovieDetailsDataProvider
    
    init(movie: Movie, dataProvider: MovieDetailsDataProvider) {
        self.movie = movie
        self.dataProviderDetails = dataProvider
    }

    func retrievedMovie() -> Object? {
        let retrievedMovie = dataProviderDetails.retrievedObject(id: movie.id)
        return retrievedMovie
    }
    
    func add(movie: Movie) {
        dataProviderDetails.add(movie: movie)
    }
    
    func delete(object: Object) {
        dataProviderDetails.delete(object: object)
    }
    
    func showTrailler() {
        guard let traillerUrl = movie.trailer else {
            return
        }
        UIApplication.shared.open(traillerUrl)
    }
}
