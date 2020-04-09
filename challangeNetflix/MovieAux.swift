//
//  MovieAux.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 09/04/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation

class MovieAux {
    
    static func searchMovie(movies: [Movie], search: String) -> [Movie] {
        
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
