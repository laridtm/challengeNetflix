//
//  MovieRealm.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 19/03/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

class MovieRealm: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var year = ""
    @objc dynamic var rated = ""
    @objc dynamic var released = ""
    @objc dynamic var runtime = ""
    @objc dynamic var genre = ""
    @objc dynamic var director = ""
    @objc dynamic var writer = ""
    @objc dynamic var actors = ""
    @objc dynamic var plot = ""
    @objc dynamic var language = ""
    @objc dynamic var country = ""
    @objc dynamic var awards = ""
    @objc dynamic var poster = ""
    @objc dynamic var metascore = ""
    @objc dynamic var resolution = false
    @objc dynamic var hdr = false
    @objc dynamic var trailer = ""
    let images = List<String>()
    
}
