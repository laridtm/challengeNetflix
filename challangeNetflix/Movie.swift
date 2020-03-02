//
//  Movie.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 28/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation

class Movie: Codable {

    let title: String
    let year: String
    let rated: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String
    let poster: String
    let metascore: String
    let resolution: Bool
    let hdr: Bool
    let images: [String]
    
    init(title: String, year: String, rated: String, released: String, runtime: String, genre: String, director: String, writer: String, actors: String, plot: String, language:String, country: String, awards: String, poster: String, metascore: String, resolution: Bool, hdr: Bool, images: [String]) {
        self.title = title
        self.year = year
        self.rated = rated
        self.released = released
        self.runtime = runtime
        self.genre = genre
        self.director = director
        self.writer = writer
        self.actors = actors
        self.plot = plot
        self.language = language
        self.country = country
        self.awards = awards
        self.poster = poster
        self.metascore = metascore
        self.resolution = resolution
        self.hdr = hdr
        self.images = images
    }
    
    enum CodingKeys: String, CodingKey {
        case Resolution = "4k"
    }
    
    required init(from Decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
      
        
    }

}
