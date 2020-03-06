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
    
    override func awakeFromNib() {
        self.layoutIfNeeded()
        layer.cornerRadius = 10
    }
    
    func configureImage(url: URL) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    let loadedImage = UIImage(data: data!)
                    self.movieImage.image = loadedImage
                    print(error)
                }
            }
        }
        task.resume()
    }
  
}
