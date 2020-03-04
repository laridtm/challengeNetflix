//
//  ViewController.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 20/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let decoder = JSONDecoder()
    var movies: [Movie] = []
    let session = URLSession.shared
    let url = URL(string: "http://localhost:8080/response.json")!
    
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
                    self.collectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
       
    func collectionView(_ collectionView: UICollectionView,     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let urlImage: URL? = movies[indexPath.row].images[2]
        
        cell.configureImage(url: urlImage!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
        return searchView
    }



}


