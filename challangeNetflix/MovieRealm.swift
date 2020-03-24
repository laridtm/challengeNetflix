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
    @objc dynamic var runtime = ""
    @objc dynamic var metascore = ""
    @objc dynamic var resolution = false
    @objc dynamic var hdr = false
    @objc dynamic var trailer = ""
    let images = List<String>()
    
}
