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
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mountScreen()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func mountScreen() {
        guard let selectedMovie = self.movie else {
            return
        }
        setPoster(urlImage: selectedMovie.images.first!)
        self.nameFilm.text = selectedMovie.title
    }
    
    func setPoster(urlImage: URL) {
        guard let data = try? Data(contentsOf: urlImage) else { return }
        coverImage.image = UIImage(data: data)
        
    }

}
