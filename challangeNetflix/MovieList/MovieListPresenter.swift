//
//  MovieListPresenter.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 06/05/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation

protocol MovieListPresentable: class {
    var view: MovieView? { get }
    func showItems(items: [Movie]?)
    func showError(error: String)
    func showBlockedView()
}

final class MovieListPresenter: MovieListPresentable {
    
    internal weak var view: MovieView?
    
    init(view: MovieView) {
        self.view = view
    }
    
    func showItems(items: [Movie]?) {
        view?.show(items: items)
    }
    
    //por enquanto tratando só sucesso, nunca vai chamar essas funções
    func showError(error: String) {
        view?.show(error: error)
    }
    
    func showBlockedView() {
        view?.blockView()
    }
    
}
