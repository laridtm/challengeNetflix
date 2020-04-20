//
//  MovieController.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 09/04/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
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
    
    func request(urlName: String) -> Data { //aqui retornar a closure
        
        let session = URLSession.shared
        let url = URL(string: urlName)!
        var responseData: Data?
        
        let task = session.dataTask(with: url) {
            data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print(error)
                    return
            }
            responseData! = data!
        }
        task.resume()
        return responseData!
        //return task
    }
    
    
}
