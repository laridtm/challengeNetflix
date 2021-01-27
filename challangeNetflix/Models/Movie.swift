//
//  Movie.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 28/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

struct Movie: Codable {
    let id: String
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
    let trailer: URL?
    let images: [URL]
    
    enum CodingKeys: String, CodingKey {
        case id, title, year, rated, released, runtime, genre, director, writer,
        actors, plot, language, country, awards, poster, metascore
        case resolution = "4k"
        case hdr, trailer, images
    }
    
    func toMovieRealm() -> MovieRealm {
        let movieRealm = MovieRealm()
        movieRealm.id = self.id
        movieRealm.title = self.title
        movieRealm.year = self.year
        movieRealm.runtime = self.runtime
        movieRealm.metascore = self.metascore
        movieRealm.resolution = self.resolution
        movieRealm.hdr = self.hdr
        return movieRealm
    }
}
