//
//  ViewController.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 20/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import UIKit
import RealmSwift

class HomeScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constraintTopCollectionView: NSLayoutConstraint!
    
    @IBAction func searchButton(_ sender: Any) {
        showSearchView()
    }

    var movies: [Movie] = []
    var realData: [Movie] = []
    let session = URLSession.shared
    let url: String = "http://localhost:8080/response.json"
    var movieSelected: Movie?
    var movieTakeData: MovieTakeData = MovieTakeData()
    
    var searchView = UICollectionReusableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closure:(Data) -> Void = { data in
            
            self.movies = self.movieTakeData.decoder(data: data)
            
            var database: MovieDatabase = MovieDatabase(config: Realm.Configuration())
            for movie in self.movies {
                let movieRealm = MovieRealm()
                
                movieRealm.id = movie.id
                movieRealm.title = movie.title
                movieRealm.year = movie.year
                movieRealm.runtime = movie.runtime
                movieRealm.metascore = movie.metascore
                movieRealm.resolution = movie.resolution
                movieRealm.hdr = movie.hdr
                
                database.addFilmDB(object: movieRealm)
            }
            
            DispatchQueue.main.async {
                self.realData = self.movies
                self.collectionView.reloadData()
            }
        }
        
        movieTakeData.request(urlName: self.url, closure: closure)
        
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
        guard let details = segue.destination as? DetailsViewController else {
            return
        }
        details.movie = movieSelected
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
        
        let movieSearch: MovieSearch = MovieSearch()
        
        self.movies = movieSearch.searchMovie(movies: realData, search: searchBar.text!)
        
        self.collectionView.reloadData()
    }
    
}


