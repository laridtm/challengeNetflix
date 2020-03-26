//
//  ViewController.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 20/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constraintTopCollectionView: NSLayoutConstraint!
    
    @IBAction func searchButton(_ sender: Any) {
        showSearchView()
    }
    
    let decoder = JSONDecoder()
    var movies: [Movie] = []
    var realData: [Movie] = []
    let session = URLSession.shared
    let url = URL(string: "http://localhost:8080/response.json")!
    var movieSelected: Movie?
    
    var searchView = UICollectionReusableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task = session.dataTask(with: url) {
            data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print(error)
                    return
            }
            
            do {
                self.movies = try self.decoder.decode([Movie].self, from: data!)
                DispatchQueue.main.async {
                    self.realData = self.movies
                    self.collectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        task.resume()
        
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
        
        addFilmDB(movie: movies[indexPath.row])
        
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
        self.movies.removeAll()

        for item in self.realData {
            if (item.title.lowercased().contains(searchBar.text!.lowercased())) {
                self.movies.append(item)
            }
        }

        if (searchBar.text!.isEmpty) {
            self.movies = self.realData
        }

        self.collectionView.reloadData()
    }
    
    func addFilmDB(movie: Movie) {
        
        let movieRealm = MovieRealm()

         movieRealm.title = movie.title
         movieRealm.year = movie.year
         movieRealm.runtime = movie.runtime
         movieRealm.metascore = movie.metascore
         movieRealm.resolution = movie.resolution
         movieRealm.hdr = movie.hdr
        
         movieRealm.setup()
         
         do {
              
             let realm = try Realm()
             
         
             try realm.write {
                realm.add(movieRealm, update: .modified)
             }
        
         
         } catch let error as NSError {
             print(error)
         }
        
        
        

    }

}


