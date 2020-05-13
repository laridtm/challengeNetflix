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
    func onFavButton()
}

class MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    
    private let presenter: MovieDetailsPresentable
    private let worker: MovieDetailsWorkerProtocol
    
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
    
    func onFavButton() {
        let retrievedObject = worker.consultDatabase()
        if retrievedObject != nil {
            worker.deleteDB(object: retrievedObject!)
            presenter.callToggleFavButton(isFavorite: false)
        } else {
            worker.addDatabase()
            presenter.callToggleFavButton(isFavorite: true)
        }
    }
}
