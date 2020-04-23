//
//  MovieController.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 09/04/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MovieTakeData {
    
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

            var database: MovieDatabase = MovieDatabase(config: Realm.Configuration())
            for movie in movies {
                database.addFilmDB(movie: movie)
            }

        } catch {
            print(error)
        }
        return movies
    }
    
    
}
