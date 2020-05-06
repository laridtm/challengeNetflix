//
//  MovieListWorker.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 06/05/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation

protocol MovieListWorkerProtocol: class {
    func request(urlName: String, closure: ((Data) -> Void)?)
    func decoder(data: Data) -> [Movie]
    func searchMovie(movies: [Movie], search: String) -> [Movie]
}

class MovieListProtocol: MovieListWorkerProtocol {
    
    func request(urlName: String, closure: ((Data) -> Void)?) {
         
         let session = URLSession.shared
         let url = URL(string: urlName)!
         
         let task = session.dataTask(with: url) {
             data, response, error in
             
             guard let httpResponse = response as? HTTPURLResponse,
                 (200...299).contains(httpResponse.statusCode) else {
                     print(error)
                     return
             }
            closure!(data!)
         }
         task.resume()
     }
    
    func decoder(data: Data) -> [Movie] {

        let decoder = JSONDecoder()
        var movies : [Movie] = []

        do {
            movies = try decoder.decode([Movie].self, from: data)
        } catch {
            print(error)
        }
        return movies
    }
    
    func searchMovie(movies: [Movie], search: String) -> [Movie] {
        
        var moviesAux: [Movie] = []
        
        for item in movies {
            if (item.title.lowercased().contains(search.lowercased())) {
                moviesAux.append(item)
            }
        }
        
        if (search.isEmpty) {
            moviesAux = movies
        }
        
        return moviesAux
    }
}
