//
//  MovieCell.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 26/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
  
    @IBOutlet weak var movieImage: UIImageView!
    
    func configureImage() {
        movieImage.image = #imageLiteral(resourceName: "malevola")
        movieImage.layer.cornerRadius = 15
    }
  
}
