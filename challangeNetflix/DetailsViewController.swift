//
//  DetailsViewController.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 04/03/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var nameFilm: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var metascore: UILabel!
    @IBOutlet weak var textFilm: UITextView!
    @IBOutlet weak var yearFilm: UILabel!
    @IBOutlet weak var timeFilm: UILabel!
    @IBOutlet weak var resolution4k: UIImageView!
    @IBOutlet weak var resolutionHDR: UIImageView!
    @IBOutlet weak var markButton: UIBarButtonItem!
    
    var movieDataBase: MovieDatabase = MovieDatabase(config: Realm.Configuration())
    
    @IBAction func traillerButton(_ sender: UIMinionButton) {
        
        guard let trailerUrl =  movie?.trailer else {
            return
        }
        UIApplication.shared.open(trailerUrl)
    }
    
    @IBAction func favButton(_ sender: UIBarButtonItem) {
        guard let selectedMovieFavorite = self.movie else {
            return
        }
        
        var isFavorite = movieDataBase.favExist(id: selectedMovieFavorite.id)
        
        if isFavorite {
            deleteFavFilm(id: selectedMovieFavorite.id)
            isFavorite = false
        } else {
            movieDataBase.addFavFilm(selected: selectedMovieFavorite)
            isFavorite = true
        }
        
        toggleFavButton(isFavorite: isFavorite)
    }
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createScreen()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    
        let isFavorite = movieDataBase.favExist(id: movie!.id)
        toggleFavButton(isFavorite: isFavorite)
    }
    
    func createScreen() {
        guard let selectedMovie = self.movie else {
            return
        }
        createPoster(urlImage: selectedMovie.images.first!)
        createBackground(urlImage: selectedMovie.images[1])
        self.nameFilm.text = selectedMovie.title
        self.metascore.text = "(\(selectedMovie.metascore))"
        self.textFilm.text = selectedMovie.plot
        self.yearFilm.text = selectedMovie.year
        self.timeFilm.text = selectedMovie.runtime
        selectEvaluation(metascore: selectedMovie.metascore)
        resolution(k: selectedMovie.resolution, HDR: selectedMovie.hdr)
    }
    
    func createPoster(urlImage: URL) {
        guard let data = try? Data(contentsOf: urlImage) else { return }
        coverImage.image = UIImage(data: data)
        coverImage.layer.cornerRadius = 10
        
    }
    
    func createBackground(urlImage: URL) {
        guard let data = try? Data(contentsOf: urlImage) else { return }
        backgroundImage.image = UIImage(data: data)
    }
    
    func selectEvaluation(metascore: String) {
        guard var metascoreDouble = Double(metascore) else { return }
        
        let images = [star1, star2, star3, star4, star5]
        var i = 1

        while i <= 5 {
            
            if metascoreDouble / 20 >= 1 {
                images[i - 1]?.image = UIImage(named: "bright-star")
            } else if metascoreDouble / 20 >= 0.5 {
                images[i - 1]?.image = UIImage(named: "kindOfbright-star")
            }
            
            metascoreDouble -= 20
                i += 1
        }
    }
    
    func resolution(k: Bool, HDR: Bool) {
        if k {
            resolution4k.image = UIImage(named: "4K")
        }
        if HDR {
            resolutionHDR.image = UIImage(named: "hdr")
        }
    }
    
    func toggleFavButton(isFavorite: Bool) {
        markButton.image = UIImage(named: isFavorite ? "marked" : "mark")
    }
    
   
    
    func deleteFavFilm(id: String) {

        do {

            let realm = try Realm()

            guard let object = realm.object(ofType: MovieFavRealm.self, forPrimaryKey: id) else {
                return
            }

            do {
                try realm.write {
                    realm.delete(object)
                }
            } catch let error as NSError {
                print(error)
            }


        } catch let error as NSError {
            print(error)
        }

    }
}
