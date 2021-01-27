//
//  MovieListInteractor.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 06/05/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

protocol MovieListInteractorProtocol: class {
    func onViewLoaded()
    func onSearchMovie(search: String)
}

class MovieListInteractor: MovieListInteractorProtocol {
    
    private let presenter: MovieListPresentable
    private let worker: MovieListWorkerProtocol
    
    private var items: [Movie]
    private let url: String = "http://localhost:8080/response.json"
    
    init(presenter: MovieListPresentable, worker: MovieListWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
        self.items = []
    }
    
    func onViewLoaded() {
        worker.request(urlName: self.url) { [weak self] items in
            self?.items = items
            self?.presenter.showItems(items: items)
        }
    }
    
    func onSearchMovie(search: String) {
        let searchResult = worker.searchMovie(movies: items, search: search)
        self.presenter.showItems(items: searchResult)
    }
}
