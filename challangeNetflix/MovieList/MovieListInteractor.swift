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
}

class MovieListInteractor: MovieListInteractorProtocol {
    
    private let presenter: MovieListPresentable
    private let worker: MovieListWorkerProtocol
    
    private var items: [Movie]
    let url: String = "http://localhost:8080/response.json"
    
    init(presenter: MovieListPresentable, worker: MovieListWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
        self.items = []
    }
    
    func onViewLoaded() {
        let closure:(Data) -> Void = { data in
            self.items = self.worker.decoder(data: data)
            var database: HandlerDatabase = HandlerDatabase(config: Realm.Configuration())
            for item in self.items {
                database.addDB(object: item.toMovieRealm())
            }
            //por enquanto tratando só sucesso
            self.presenter.showItems(items: self.items)
        }
        worker.request(urlName: self.url, closure: closure)
    }
}
