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

//         self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func mountScreen() {
        setPoster(urlImage: movie!.poster)
    }
    
    func setPoster(urlImage: String) {
        if let url = URL(string: urlImage) {
            guard let data = try? Data(contentsOf: url) else { return }
            coverImage.image = UIImage(data: data)
        }
    }

}
