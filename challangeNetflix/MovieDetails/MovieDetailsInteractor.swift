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
    func onFavTapped()
}

class MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    
    private let presenter: MovieDetailsPresentable
    private let worker: MovieDetailsWorkerProtocol
    
    init(presenter: MovieDetailsPresentable, worker: MovieDetailsWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func onViewLoaded() {
        self.presenter.show(item: worker.movie)
        let retrievedObject = worker.consultDatabase()
        if retrievedObject != nil {
            presenter.toggleFavButton(favorite: true)
        } else {
            presenter.toggleFavButton(favorite: false)
        }
    }
    
    func onFavTapped() {
        let retrievedObject = worker.consultDatabase()
        if retrievedObject != nil {
            worker.delete(object: retrievedObject!)
            presenter.toggleFavButton(favorite: false)
        } else {
            worker.add()
            presenter.toggleFavButton(favorite: true)
        }
    }
}
