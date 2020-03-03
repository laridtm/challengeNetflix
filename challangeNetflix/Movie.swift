//
//  Movie.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 28/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation

struct Movie: Codable {

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
    let images: [URL]
    
//    init(title: String, year: String, rated: String, released: String, runtime: String, genre: String, director: String, writer: String, actors: String, plot: String, language:String, country: String, awards: String, poster: String, metascore: String, resolution: Bool, hdr: Bool, images: [String]) {
//        self.title = title
//        self.year = year
//        self.rated = rated
//        self.released = released
//        self.runtime = runtime
//        self.genre = genre
//        self.director = director
//        self.writer = writer
//        self.actors = actors
//        self.plot = plot
//        self.language = language
//        self.country = country
//        self.awards = awards
//        self.poster = poster
//        self.metascore = metascore
//        self.resolution = resolution
//        self.hdr = hdr
//        self.images = images
//    }
    
    enum CodingKeys: String, CodingKey {
        case title, year, rated, released, runtime, genre, director, writer,
        actors, plot, language, country, awards, poster, metascore
        case resolution = "4k"
        case hdr, images
        
    }
    
    init(from Decoder: Decoder) throws {
        let values = try Decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        year = try values.decode(String.self, forKey: .year)
        rated = try values.decode(String.self, forKey: .rated)
        released = try values.decode(String.self, forKey: .released)
        runtime = try values.decode(String.self, forKey: .runtime)
        genre = try values.decode(String.self, forKey: .genre)
        director = try values.decode(String.self, forKey: .director)
        writer = try values.decode(String.self, forKey: .writer)
        actors = try values.decode(String.self, forKey: .actors)
        plot = try values.decode(String.self, forKey: .plot)
        language = try values.decode(String.self, forKey: .language)
        country = try values.decode(String.self, forKey: .country)
        awards = try values.decode(String.self, forKey: .awards)
        poster = try values.decode(String.self, forKey: .poster)
        metascore = try values.decode(String.self, forKey: .metascore)
        resolution = try values.decode(Bool.self, forKey: .resolution)
        hdr = try values.decode(Bool.self, forKey: .hdr)
        images = try values.decode([URL].self, forKey: .images)
    }

}
