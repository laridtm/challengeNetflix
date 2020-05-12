//
//  ViewController.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 20/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import UIKit
import RealmSwift

protocol MovieView: class {
    func show(items: [Movie]?)
    func show(error: String)
    func blockView()
}

class MovieListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constraintTopCollectionView: NSLayoutConstraint!
    @IBAction func searchButton(_ sender: Any) {
        showSearchView()
    }

    var movies: [Movie] = []
    var movieSelected: Movie?
    var searchView = UICollectionReusableView()
    
    var interactor: MovieListInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.onViewLoaded()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        guard let urlImage: URL = movies[indexPath.row].images[2] else {
            print(Error.self)
            return UICollectionViewCell()
        }
        cell.configureImage(url: urlImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieSelected = movies[indexPath.row]
        performSegue(withIdentifier: "Details", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let details = segue.destination as? MovieDetailsViewController else {
            return
        }
        let controllerDetails = details
        let presenterDetails = MovieDetailsPresenter(view: controllerDetails)
        let workerDetails = MovieDetailsWorker()
        let interactorDetails = MovieDetailsInteractor(presenter: presenterDetails, worker: workerDetails)
        controllerDetails.interactor = interactorDetails
        
        workerDetails.movie = movieSelected
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        searchView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
        hideSearchView()
        return searchView

    }
    
    func hideSearchView() {
        searchView.isHidden = true
    }
    
    func showSearchView() {
        if searchView.isHidden {
            UIView.animate(withDuration: 3.0) {
                self.constraintTopCollectionView.constant = 0
                self.searchView.isHidden = false
            }
        } else if searchView.isHidden == false {
            UIView.animate(withDuration: 3.0) {
                self.constraintTopCollectionView.constant = -56
                self.searchView.isHidden = true
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        interactor?.onSearchMovie(search: searchBar.text!)
    }
    
}

extension MovieListViewController: MovieView {
    
    func show(items: [Movie]?) {
        self.movies = items!
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func show(error: String) {
//        showSimpleAlertController(title: "error".localized(), message: error)
    }
    
    func blockView() {
//        let blockViewController = R.storyboard.block().instantiateInitialViewController()
//        
//        if let blockView = blockViewController?.view {
//            self.view.addSubview(blockView)
//        }
    }
    
}


