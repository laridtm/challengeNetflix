//
//  MovieListWorker.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 06/05/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

protocol MovieListWorkerProtocol: class {
    func request(urlName: String, completion: (([Movie]) -> Void)?)
    func searchMovie(movies: [Movie], search: String) -> [Movie]
    var dataProviderList: MovieListDataProvider { get }
}

class MovieListWorker: MovieListWorkerProtocol {
    let dataProviderList: MovieListDataProvider

    init(dataProvider: MovieListDataProvider) {
        self.dataProviderList = dataProvider
    }

    func request(urlName: String, completion: (([Movie]) -> Void)?) {
        let session = URLSession.shared
        guard let url = URL(string: urlName) else { return }
        let task = session.dataTask(with: url) { [weak self]
            data, response, error in

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print(error)
                    return
            }
            guard let data = data else {
                return
            }
            guard let movies = try? JSONDecoder().decode([Movie].self, from: data) else {
                print(error)
                return
            }
            
            self?.dataProviderList.add(movies: movies)
            completion!(movies)
        }
        task.resume()
        
    }

    func searchMovie(movies: [Movie], search: String) -> [Movie] {
        var responseMovies = movies.filter { $0.title.lowercased().contains(search.lowercased()) }

        if (search.isEmpty) {
            responseMovies = movies
        }

        return responseMovies
    }
}
