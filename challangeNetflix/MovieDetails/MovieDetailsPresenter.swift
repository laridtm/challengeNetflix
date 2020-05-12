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
    func showItem(item: Movie?)
    func showError(error: String)
    func showBlockedView()
    func callToggleFavButton(isFavorite: Bool)
}

final class MovieDetailsPresenter: MovieDetailsPresentable {
    
    internal weak var view: MovieViewDetails?
    
    init(view: MovieViewDetails) {
        self.view = view
    }
    
    func callToggleFavButton(isFavorite: Bool) {
        view?.toggleFavButton(isFavorite: isFavorite)
    }
    
    func showItem(item: Movie?) {
        view?.show(item: item)
    }
    
    //por enquanto tratando só sucesso, nunca vai chamar essas funções
    func showError(error: String) {
        view?.show(error: error)
    }
    
    func showBlockedView() {
        view?.blockView()
    }
    
}
