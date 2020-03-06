//
//  DetailsViewController.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 04/03/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var nameFilm: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var metascore: UILabel!
    
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
    }
    
    func createScreen() {
        guard let selectedMovie = self.movie else {
            return
        }
        createPoster(urlImage: selectedMovie.images.first!)
        createBackground(urlImage: selectedMovie.images[1])
        self.nameFilm.text = selectedMovie.title
        self.metascore.text = "(\(selectedMovie.metascore))"
        selectEvaluation(metascore: selectedMovie.metascore)
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
        guard let metascoreInt = Int(metascore) else { return }
        
        if metascoreInt <= 20 {
            if metascoreInt == 0 {
               self.star1.image = UIImage(named: "star")
            } else {
               self.star1.image = UIImage(named: "bright-star")
            }
            
        } else if metascoreInt > 20 && metascoreInt <= 40 {
            self.star1.image = UIImage(named: "bright-star")
            self.star2.image = UIImage(named: "bright-star")
            
        } else if metascoreInt > 40 && metascoreInt <= 60 {
            self.star1.image = UIImage(named: "bright-star")
            self.star2.image = UIImage(named: "bright-star")
            self.star3.image = UIImage(named: "bright-star")
            
        } else if metascoreInt > 60 && metascoreInt <= 80 {
            self.star1.image = UIImage(named: "bright-star")
            self.star2.image = UIImage(named: "bright-star")
            self.star3.image = UIImage(named: "bright-star")
            self.star4.image = UIImage(named: "bright-star")
            
        } else if metascoreInt > 80 {
            self.star1.image = UIImage(named: "bright-star")
            self.star2.image = UIImage(named: "bright-star")
            self.star3.image = UIImage(named: "bright-star")
            self.star4.image = UIImage(named: "bright-star")
            self.star5.image = UIImage(named: "bright-star")
        }

    }

}
