//
//  MovieDetailsPresenter.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 12/05/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation

protocol MovieDetailsPresentable: class {
    var view: MovieViewDetails? { get }
    func show(item: Movie)
    func toggleFavButton(favorite: Bool)
}

final class MovieDetailsPresenter: MovieDetailsPresentable {
    
    internal weak var view: MovieViewDetails?
    
    init(view: MovieViewDetails) {
        self.view = view
    }
    
    func toggleFavButton(favorite: Bool) {
        view?.toggleFavButton(favorite: favorite)
    }
    
    func show(item: Movie) {
        view?.show(item: item)
    }
}
