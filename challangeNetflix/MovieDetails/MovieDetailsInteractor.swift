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
    func showTrailler()
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
        let movie = worker.retrieveMovie()
        presenter.toggleFavButton(favorite: movie != nil)
    }
    
    func onFavTapped() {
        if let movie = worker.retrieveMovie() {
            worker.delete(object: movie)
            presenter.toggleFavButton(favorite: false)
        } else {
            worker.add(movie: self.worker.movie)
            presenter.toggleFavButton(favorite: true)
        }
    }
    
    func showTrailler() {
        worker.showTrailler()
    }
}
