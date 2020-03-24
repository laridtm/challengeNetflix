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
        
        var isFavorite = favExist(title: selectedMovieFavorite.title)
        
        if isFavorite {
            deleteFavFilm(title: selectedMovieFavorite.title)
            isFavorite = false
        } else {
            createRealm()
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
    
    var realm: Realm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            realm = try Realm()
            
        } catch let error as NSError {
            print(error)
        }
        
        createScreen()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        var isFavorite = favExist(title: movie!.title)
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

        if isFavorite {
            markButton.image = UIImage(named: "marked")
        } else {
            markButton.image = UIImage(named: "mark")
        }


    }
    
    func favExist (title: String) -> Bool {
        
        let realm = try! Realm()
        
        let objects = realm.objects(MovieRealm.self).filter("title = \"\(title)\"")

        if objects.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func deleteFavFilm(title: String) {
        
        let realm = try! Realm()
        
        let objects = realm.objects(MovieRealm.self).filter("title = \"\(title)\"")

        try! realm.write {
            realm.delete(objects)
        }
    }

    func createRealm() {
        
        let movieRealm = MovieRealm()
        
        movieRealm.title = self.movie!.title
        movieRealm.year = self.movie!.year
        movieRealm.runtime = self.movie!.runtime
        movieRealm.metascore = self.movie!.metascore
        movieRealm.resolution = self.movie!.resolution
        movieRealm.hdr = self.movie!.hdr
//        movieRealm.trailer = self.movie!.trailer
//        movieRealm.images = self.movie!.images
           
        do {
            try realm?.write {
                realm?.add(movieRealm)
            }
        } catch let error as NSError {
            print(error)
        }
        
       
        
    }

}
