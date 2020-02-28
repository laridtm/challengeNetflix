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
    let year: Int
    let rated: String
    let released: String
    let runtine: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String
    let poster: String
    let metascore: Int
    //trocar nome 4k por resolution
    let resolution: Bool
    let hdr: Bool
    let images: [String]

}
