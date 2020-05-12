//
//  DetailsViewController.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 04/03/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import UIKit
import RealmSwift

protocol MovieViewDetails: class {
    func show(item: Movie?)
    func show(error: String)
    func blockView()
    func toggleFavButton(isFavorite: Bool)
}

class MovieDetailsViewController: UIViewController {
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
    
    var interactor: MovieDetailsInteractorProtocol?
    var movie: Movie?
    
    @IBAction func traillerButton(_ sender: UIMinionButton) {
        guard let trailerUrl =  movie?.trailer else {
            return
        }
        UIApplication.shared.open(trailerUrl)
    }
    
    @IBAction func favButton(_ sender: UIBarButtonItem) {
        interactor?.onFavButton(movie: movie!)
    }
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    
        interactor?.onViewLoaded()
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
}

extension MovieDetailsViewController: MovieViewDetails {
    
    func toggleFavButton(isFavorite: Bool) {
        markButton.image = UIImage(named: isFavorite ? "marked" : "mark")
    }
    
    func show(item: Movie?) {
        self.movie = item!
        createScreen()
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
