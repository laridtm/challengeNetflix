//
//  MovieFavRealm.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 27/03/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

class MovieFavRealm: Object {
    @objc dynamic var id = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
