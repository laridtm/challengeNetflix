//
//  MovieDetailsInteractor.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 12/05/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

protocol MovieDetailsInteractorProtocol: class {
    func onViewLoaded()
    func onFavButton(movie: Movie!)
}

class MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    
    private let presenter: MovieDetailsPresentable
    private let worker: MovieDetailsWorkerProtocol
    var movie: Movie?
    
    init(presenter: MovieDetailsPresentable, worker: MovieDetailsWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func onViewLoaded() {
        self.presenter.showItem(item: worker.movie)
        let retrievedObject = worker.consultDatabase()
        if retrievedObject != nil {
            presenter.callToggleFavButton(isFavorite: true)
        } else {
            presenter.callToggleFavButton(isFavorite: false)
        }
    }
    
    func onFavButton(movie: Movie!) {
        guard let selectedMovieFavorite = movie else {
            return
        }
        let retrievedObject = worker.consultDatabase()
        if retrievedObject != nil {
            worker.deleteDB(object: retrievedObject!)
            presenter.callToggleFavButton(isFavorite: false)
        } else {
            worker.addDatabase(movie: selectedMovieFavorite)
            presenter.callToggleFavButton(isFavorite: true)
        }
    }
}
